open Core
open Pervasives

open Utils

let shift_or (pattern : string) (text : string) =
  let pattern_size = String.length pattern in
  let b =
    bitmask (String.to_list pattern)
    |> List.map ~f:(complement_mask_pair pattern_size)
  in
  let t = String.to_list text in
  let m = List.length b in
  let end_mask = (lsl) 1 m in

  let rec shift_or' text' d p =
    match List.nth text' 0 with
      | None -> Miss(pattern, text)
      | Some(c) ->
        let text'' = List.drop text' 1 in
        match find_mask c b with
        | Some((mask, _)) ->
            let d' = (d lsl 1) in
            let d'' = d' lor mask in
            let d''' = (d'' land end_mask) in
            let is_hit = d''' == 0 in
            if is_hit then Hit(pattern, text, Position(0, p))
            else
              let p' = if d == 0 then p+1 else p in
              shift_or' text'' d'' p'
        | None -> shift_or' text'' 0 (p+1)
  in

  shift_or' t 0 0
