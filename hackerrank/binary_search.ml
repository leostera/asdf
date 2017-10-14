open Core
open Pervasives
open Core.Option.Monad_infix
open Core.Quickcheck

let rec bs (l : int Core.List.t) ?(i=(List.length l - 1)/2) (k : int) =
  if List.is_empty l then None
  else
    let nth = List.nth l i in
    nth
    >>| compare k
    >>= (fun x -> match x with
        | -1 -> bs (List.take l i) k
        | 1 -> bs (List.drop l (i+1)) k
        | _ -> nth
      )
