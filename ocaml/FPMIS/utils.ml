open Core
open Pervasives

type position = Position of int * int
type result =
  | Hit of string * string * position
  | Miss of string * string

(*
 * Printing helpers
 *)

let pad (c : string) (padding : int) =
  List.range ~start:`inclusive ~stop:`exclusive 0 padding
  |> List.map ~f:(fun _ -> c)
  |> List.fold ~f:(^) ~init:""

let int_to_binary_string (size : int) (i : int) =
  let rec int_to_bin x =
    if x == 0 then [0] else
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
  let result = int_to_bin i
    |> List.map ~f:Int.to_string
    |> List.rev
    |> List.fold ~f:(^) ~init:""
  in
  let padding = pad "0" (size - String.length result) in
  padding ^ result

let readable_bitmask size =
  List.map ~f:(fun (i, c) -> (int_to_binary_string size i, c))

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

let bitmask = List.foldi ~init:[] ~f:bitmask_for_char
let bitmask_from_string (s : string) = String.to_list s |> bitmask
