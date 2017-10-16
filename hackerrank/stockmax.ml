open Core
open Pervasives
open Option.Monad_infix
open In_channel

type shares = Count of int
type day = Day of int
type net_worth = Worth of int
type price = Price of int

type kind = Buy | Sell | Hold | Open | Close

type step = Step of kind * price * day * shares * net_worth * int list

let read_cases (count : int) =
  let rec read_cases' n acc =
    match n with
    | 0 -> Some(acc)
    | n ->
      let __days = input_line In_channel.stdin in
      input_line ~fix_win_eol:true In_channel.stdin
      >>| String.split_on_chars ~on:[' ']
      >>| List.map ~f:int_of_string
      >>| List.mapi ~f:(fun i x -> (x, i))
      >>| (fun x -> [x])
      >>| List.append acc
      >>= read_cases' (n-1)
  in
  read_cases' count []

let trade last_step price = match last_step with
  | Step(_, _, Day(day), Count(shares), Worth(net_worth), (max_price::rest)) ->
    let () = Printf.printf "Max: %d – Price: %d – Worth: %d\n" max_price price net_worth in
    if price < max_price then
      Step(
        Buy,
        Price(price),
        Day(succ day),
        Count(succ shares),
        Worth(net_worth - price),
        (max_price::rest))
    else
      Step(
        Sell,
        Price(price),
        Day(succ day),
        Count(0),
        Worth(net_worth + (shares * max_price)),
        rest)
  | Step(s, Price(p), Day(day), Count(shares), Worth(net_worth), []) ->
    Step(Close, Price(p), Day(day+1), Count(0), Worth(net_worth + (shares * p)), [])

let process_case case =
  (* helper functions *)
  let max_price (x, i) (y, j) = compare y x in
  let prices_from = List.map ~f:fst in

  let sorted = List.sort ~cmp:max_price case in
  let sorted_prices = prices_from sorted in
  let no_price_raise = match (List.hd sorted >>| snd >>| phys_same 0) with
    | Some x -> x
    | None -> false
  in

  if no_price_raise
  then Step(Hold, Price(0), Day(0), Count(0), Worth(0), sorted_prices)
  else List.fold_left
      ~f:trade
      ~init:(Step(Open, Price(0), Day(0), Count(0), Worth(0), sorted_prices))
      (prices_from case)

let print_results (steps : step list) =
  steps
  |> List.map ~f:(function Step(_, _, _, _, Worth(w), _) -> w)
  |> List.iter ~f:(Printf.printf "%d\n")

let gather_inputs () =
  input_line ~fix_win_eol:true In_channel.stdin
  >>| Int.of_string
  >>= read_cases

let res () = gather_inputs () >>| List.map ~f:process_case

let () = match (res ()) with
  | Some x -> print_results x
  | None -> Printf.printf "No results available"
