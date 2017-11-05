open Core
open In_channel
open Out_channel

(*
 * Spec:
 *   read_accounts : Path -> Account list
 *   assesment : CreditCardNumber -> Amount -> AuthorizationResult
 *)

type credit_card = CreditCard of string
type amount = Amount of int

type timestamp = Tmp of int
type purchase = Purchase of timestamp * amount

type account =
  | Account of credit_card * amount
  | InvalidAccount

type auth_result =
  | Declined
  | Approved

let parse line =
  match (String.split ~on:' ' line) with
  | cc::amount::_ -> Account(CreditCard(cc), Amount(int_of_string amount))
  | _ -> InvalidAccount

let read_accounts path =
  In_channel.read_lines path
  |> List.map ~f:parse

let to_string ac =
  match ac with
  | Account(CreditCard(cc), Amount(a)) -> Printf.sprintf "%s %d" cc a
  | _ -> "X X"

let update_balance cc am =
  read_accounts "./accounts"
  |> List.map ~f:(fun x ->
      match x with
      | Account(CreditCard(cc'), Amount(a)) when (String.equal cc cc') ->
        Account(CreditCard(cc'), Amount(am))
      | x -> x
    )
  |> List.map ~f:to_string
  |> Out_channel.write_lines "./accounts"

let asses_risk ac (Amount x) : auth_result =
  match ac with
  | InvalidAccount -> Declined
  | Account(CreditCard(cc), Amount(limit)) ->
    if x > limit then Declined
    else
      let () = update_balance cc (limit - x) in
      Approved

let find_account (CreditCard cc) account =
  match account with
  | Account(CreditCard(cc'), _) -> String.equal cc cc'
  | InvalidAccount -> false

(* in transaction *)
let authorize (cc : credit_card) (x : amount) : auth_result =
  let accounts = read_accounts "./accounts" in
  let result = List.find ~f:(find_account cc) accounts in
  match result with
  | Some(account) -> asses_risk account x
  | None -> Declined

let cc = CreditCard("1234")
let am = Amount(1234)
