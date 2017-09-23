open Core
open Pervasives

type result =
    (* pattern, body, position *)
    Hit of string * string * int
  | Miss of string * string

(*
 * Printing helpers
 *)

let int_to_binary_string (i : int) =
  let rec int_to_bin x =
    let div = x / 2 in
    let rest = x mod 2 in
    if x == 1
      then [1]
      else
        if rest == 0 && div == 1
        then
          [rest ; div]
    else
      [rest] @ int_to_bin div
  in
  int_to_bin i
  |> List.map ~f:Int.to_string
  |> List.rev
  |> List.fold ~f:(^) ~init:""

let readable_bitmask = List.map ~f:(fun (i, c) -> (int_to_binary_string i, c))


(*
 * Bitmask helpers
 *)

let bitmask_for_char i r c =
  let is_char = fun (_, c') -> c == c' in
  let is_not_char c = is_char c |> (not) in
  let position = (lsl) 1 i in
  match List.find r is_char with
  | Some(i', _) -> (List.filter r is_not_char) @ [ ((lor) i' position, c) ]
  | None -> r @ [ (position, c) ]

let bitmask (s : char list) = List.foldi s ~init:[] ~f:bitmask_for_char

(*
 * Shift/And Algorithm
 *)

let shift_and (pattern : string) (text : string) =
  let b = bitmask (String.to_list pattern) in
  let t = String.to_list text in
  let m = List.length b in
  let end_mask = (lsl) 1 m-1 in
  let rec shift_and' text' d =
    let first_char = List.rev text' |> List.last in
    match first_char with
    | Some(c) ->
      let text'' = List.drop text' 1 in
      let maybe_mask = List.find ~f:(fun (m, c') -> c == c') b in
      match maybe_mask with
      | Some((mask, _)) ->
          let d' = ((d lsl 1) lor (1 lsl m-1)) land mask in
          if (d' land end_mask) != 0
          then Hit(pattern, text, (String.length text) - (List.length text'))
          else shift_and' text'' d'
      | None -> shift_and' text'' 0
    | None -> Miss(pattern, text)
  in
  shift_and' t 0

(*
 * Sample values
 *)

let a = shift_and "hello" "oh hello world"
let a' = shift_and "hello" "oh world"
let five = int_to_binary_string 5
let sas = String.to_list "sas" |> bitmask |> readable_bitmask
