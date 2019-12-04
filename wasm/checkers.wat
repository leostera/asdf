(module

  ;; Imports
  (import "events" "pieceMoved"
          (func $notify-piece-moved (param $from-x i32) (param $from-y i32)
                (param $to-x i32) (param $to-y i32)))

  (import "events" "invalidMove"
          (func $notify-invalid-move (param $from-x i32) (param $from-y i32)
                (param $to-x i32) (param $to-y i32)))

  (import "events" "pieceCrowned"
          (func $notify-piece-crowned
                (param $piece-x i32) (param $piece-y i32)))

  ;; Memory
  (memory $mem 1)

  ;; Constants
  (global $BLACK i32 (i32.const 1))
  (global $WHITE i32 (i32.const 2))
  (global $CROWN i32 (i32.const 4))
  (global $CURRENT_TURN (mut i32) (i32.const 0))

  ;; Position helper functions
  (func $index-for-position (param $x i32) (param $y i32) (result i32)
        (i32.add
          (i32.mul (i32.const 8) (get_local $y))
          (get_local $x)))

  (func $offset-for-position (param $x i32) (param $y i32) (result i32)
        (i32.mul
          (call $index-for-position (get_local $x) (get_local $y))
          (i32.const 4)))

  ;; Piece helper functions
  (func $is-crowned (param $piece i32) (result i32)
        (i32.eq
          (i32.and (get_local $piece) (get_global $CROWN))
          (get_global $CROWN)))

  (func $is-white (param $piece i32) (result i32)
        (i32.eq
          (i32.and (get_local $piece) (get_global $WHITE))
          (get_global $WHITE)))

  (func $is-black (param $piece i32) (result i32)
        (i32.eq
          (i32.and (get_local $piece) (get_global $BLACK))
          (get_global $BLACK)))

  (func $with-crown (param $piece i32) (result i32)
        (i32.or (get_local $piece) (get_global $CROWN)))

  (func $without-crown (param $piece i32) (result i32)
        (i32.and (get_local $piece) (i32.const 3)))

  (func $set-piece (param $x i32) (param $y i32) (param $piece i32)
        (i32.store
          (call $offset-for-position (get_local $x) (get_local $y))
          (get_local $piece)))

  (func $get-piece (param $x i32) (param $y i32) (result i32)
        (if (result i32)
          (block (result i32)
                 (i32.and
                   (call $in-range (i32.const 0) (i32.const 7) (get_local $x))
                   (call $in-range (i32.const 0) (i32.const 7) (get_local $y))))
          (then
            (i32.load
              (call $offset-for-position (get_local $x) (get_local $y))))
          (else (unreachable))))

  (func $in-range (param $low i32) (param $high i32)
        (param $value i32) (result i32)
        (i32.and
          (i32.ge_s (get_local $value) (get_local $low))
          (i32.le_s (get_local $value) (get_local $high))))

  (func $get-turn-owner (result i32) (get_global $CURRENT_TURN))

  (func $set-turn-owner (param $piece i32)
        (set_global $CURRENT_TURN (get_local $piece)))

  (func $toggle-turn-owner
        (if (i32.eq (call $get-turn-owner (i32.const 1)))
          (then (call $set-turn-owner (i32.const 2)))
          (else (call $set-turn-owner (i32.const 1)))))

  (func $is-players-turn (param $player i32) (result i32)
        (i32.gt_s
          (i32.and (get_local $player) (call $get-turn-owner))
          (i32.const 0)))

  (func $should-crown (param $piece-y i32) (param $piece i32) (result i32)
        (i32.or
          (i32.and (i32.eq (get_local $piece-y) (i32.const 0))
                   (call $is-black (get_local $piece)))
          (i32.and (i32.eq (get_local $piece-y) (i32.const 7))
                   (call $is-white (get_local $piece)))))

  (func $crown-piece (param $x i32) (param $y i32)
        (local $piece i32)
        (set_local $piece (call $get-piece (get_local $x) (get_local $y)))
        (call $set-piece (get_local $x) (get_local $y)
              (call $with-crown (get_local $piece)))
        (call $notify-piece-crowned (get_local $x) (get_local $y)))

  (func $distance (param $x i32) (param $y i32) (result i32)
        (i32.sub (get_local $x) (get_local $y)))

  (func $is-valid-move (param $from-x i32) (param $from-y i32)
        (param $to-x i32) (param $to-y i32) (result i32)
        (local $player i32)
        (local $target i32)
        (set_local $player
                   (call $get-piece (get_local $from-x) (get_local $from-y)))
        (set_local $target
                   (call $get-piece (get_local $to-x) (get_local $to-y)))
        (if (result i32)
          (block (result i32)
                 (i32.and
                   (call $valid-jump-distance (get_local $from-y) (get_local $to-y))
                   (i32.and
                     (call $is-players-turn (get_local $player))
                     (i32.eq (get_local $target) (i32.const 0)))))
          (then (i32.const 1))
          (else (i32.const 0))))

  (func $valid-jump-distance (param $from i32) (param $to i32) (result i32)
        (local $d i32)
        (set_local $d
                   (if (result i32)
                     (i32.gt_s (get_local $to) (get_local $from))
                     (then (call $distance (get_local $to) (get_local $from)))
                     (else (call $distance (get_local $from) (get_local $to)))))
        (i32.le_u (get_local $d) (i32.const 2)))

  (func $move (param $from-x i32) (param $from-y i32)
        (param $to-x i32) (param $to-y i32) (result i32)
        (if (result i32)
          (block (result i32)
                 (call $is-valid-move (get_local $from-x) (get_local $from-y)
                       (get_local $to-x) (get_local $to-y)))
          (then (call $do_move (get_local $from-x) (get_local $from-y)
                      (get_local $to-x) (get_local $to-y)))
          (else
            (block (result i32)
                   (call $notify-invalid-move
                         (get_local $from-x) (get_local $from-y)
                         (get_local $to-x) (get_local $to-y))
                   (i32.const 0)))))

  (func $do_move (param $from-x i32) (param $from-y i32)
        (param $to-x i32) (param $to-y i32) (result i32)
        (local $current-piece i32)
        (set_local $current-piece
                   (call $get-piece (get_local $from-x) (get_local $from-y)))
        (call $toggle-turn-owner)
        (call $set-piece (get_local $to-x) (get_local $to-y) 
              (get_local $current-piece))
        (call $set-piece (get_local $from-x) (get_local $from-y) 
              (i32.const 0))
        (if (call $should-crown (get_local $to-x) (get_local $current-piece))
          (then (call $crown-piece (get_local $to-x) (get_local $to-y))))
        (call $notify-piece-moved (get_local $from-x) (get_local $from-y)
              (get_local $to-x) (get_local $to-y))
        (i32.const 1))

  (func $init-board
        (call $set-piece (i32.const 1) (i32.const 0) (i32.const 2))
        (call $set-piece (i32.const 3) (i32.const 0) (i32.const 2))
        (call $set-piece (i32.const 5) (i32.const 0) (i32.const 2))
        (call $set-piece (i32.const 7) (i32.const 0) (i32.const 2))
        (call $set-piece (i32.const 2) (i32.const 1) (i32.const 2))
        (call $set-piece (i32.const 4) (i32.const 1) (i32.const 2))
        (call $set-piece (i32.const 6) (i32.const 1) (i32.const 2))
        (call $set-piece (i32.const 8) (i32.const 1) (i32.const 2))
        (call $set-piece (i32.const 1) (i32.const 8) (i32.const 1))
        (call $set-piece (i32.const 3) (i32.const 8) (i32.const 1))
        (call $set-piece (i32.const 5) (i32.const 8) (i32.const 1))
        (call $set-piece (i32.const 7) (i32.const 8) (i32.const 1))
        (call $set-piece (i32.const 2) (i32.const 7) (i32.const 1))
        (call $set-piece (i32.const 4) (i32.const 7) (i32.const 1))
        (call $set-piece (i32.const 6) (i32.const 7) (i32.const 1))
        (call $set-piece (i32.const 8) (i32.const 7) (i32.const 1))
        (call $set-turn-owner (i32.const 1)))


  ;; Exports
  (export "get_piece" (func $get-piece))
  (export "init_board" (func $init-board))
  (export "get_turn_owner" (func $get-turn-owner))
  (export "move" (func $move))
  (export "memory" (memory $mem))

  (export "offset_for_position" (func $offset-for-position))
  (export "is_crowned" (func $is-crowned))
  (export "is_black" (func $is-black))
  (export "is_white" (func $is-white))
  (export "with_crown" (func $with-crown))
  (export "without_crown" (func $without-crown)))
