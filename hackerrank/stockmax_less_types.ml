open Core
open Option.Monad_infix
open In_channel

(*------------------------------------------------------------------------------
 *  Replaced named types with tuples
 *  Replaced succ calls with +1
 *-----------------------------------------------------------------------------*)

let read_cases (count : int) =
  let rec read_cases' n acc =
    match n with
    | 0 -> if List.length acc > 0 then Some(acc) else None
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

let max_price (x, i) (y, j) = if x > y then -1 else 1

let trade acc price = match (List.last acc) with
  | None -> []
  | Some x -> match x with
    | (_, (day), (shares), (net_worth), (max_price::rest)) ->
      List.append acc [
        if price < max_price then
          (
            price,
            (day + 1),
            (shares + 1),
            (net_worth - price),
            (max_price::rest))
        else
          (
            price,
            (day + 1),
            (0),
            (net_worth + (shares * max_price)),
            rest)
      ]
    | _ -> acc

let process_case case =
  let sorted = List.sort ~cmp:max_price case in
  let no_price_raise =
    match (List.hd sorted >>| snd >>| phys_same 0) with
    | Some x -> x
    | None -> false
  in
  let prices = List.map ~f:fst in
  if no_price_raise
  then [((0), (0), (0), (0), (prices sorted))]
  else
    prices case
    |> List.fold_left
      ~f:trade
      ~init:[((0), (0), (0), (0), (prices sorted))]

let get_worth = function (_, _, _, (w), _) -> w

let print_results steps =
  steps
  |> List.map ~f:(List.last)
  |> List.map ~f:(fun x -> match x with
      | Some x -> get_worth x
      | None -> 0)
  |> List.iter ~f:(Printf.printf "%d\n")

let res =
  input_line ~fix_win_eol:true In_channel.stdin
  >>| Int.of_string
  >>= read_cases
  >>| List.map ~f:process_case

let () = match res with
  | Some x -> print_results x
  | None -> Printf.printf "No results available"
