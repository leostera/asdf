open Format

(*----------------------------------------------------------------------------
 * Types
 *----------------------------------------------------------------------------*)

(* filepath, line number, column number *)
type info = FI of string * int * int | UNKNOWN

type binding = NameBind
type context = (string * binding) list

type term =
  (* de Bruijn indexes: variable index and current index *)
    TmVar of info * int * int

  (* abstraction with function name and body *)
  | TmAbs of info * string * term

  (* function application *)
  | TmApp of info * term * term

(*----------------------------------------------------------------------------
 * Printing
 *----------------------------------------------------------------------------*)

(* the length of a context is the amount of elements it has *)
let ctxLength = List.length

let printCtx ctx =
  Printf.sprintf "[%s]" (String.concat "," (List.map (fun (a,_) -> a) ctx))

let nameFromIndex fi ctx index =
  try
    let (name, _) = List.nth ctx (index-1) in
    Some(name)
  with Failure _ ->
    None

let rec isnamebound ctx name =
  match ctx with
      [] -> false
    | (name', _)::rest ->
        if name = name' then true
        else isnamebound rest name

let rec disambiguate ctx name =
  if isnamebound ctx name then disambiguate ctx (name^"'")
  else ((name, NameBind)::ctx), name

(* pretty print a term based on a context *)
let rec printTerm' (ctx : context) (t : term) : string = match t with
    TmAbs(fi, name, body) ->
      let (ctx', name') = disambiguate ctx name in
      Printf.sprintf "(λ%s. %s)" name' (printTerm' ctx' body)
  | TmApp(fi, name, args) ->
      Printf.sprintf "(%s %s)" (printTerm' ctx name) (printTerm' ctx args)
  | TmVar(fi, current, consistencyCheck) ->
      if ctxLength ctx = consistencyCheck then
        match (nameFromIndex fi ctx current) with
            Some(name) -> Printf.sprintf "%s" name
          | None -> Printf.sprintf
              "Variable lookup failed: offset(%d), ctx size(%d)"
              current (ctxLength ctx)
      else
        Printf.sprintf
          "[bad idea! Context(%s) Current(%d) Consistency(%d)]"
          (printCtx ctx) current consistencyCheck

let printTerm ctx t = Printf.printf "%s" (printTerm' ctx t)

(*----------------------------------------------------------------------------
 * Shifting & Substitution
 *----------------------------------------------------------------------------*)

let mapTerm onvar shift term =
  let rec walk c t = match t with
      TmVar(fi, n, m) -> onvar shift c fi n m
    | TmAbs(fi, n, t') -> TmAbs(fi, n, walk (c+1) t')
    | TmApp(fi, t1, t2) -> TmApp(fi, walk (c+1) t1, walk (c+1) t2)
  in walk 0 term

let termShift' shift cutoff fi current check =
  if current >= cutoff then TmVar(fi, current+shift, check+shift)
  else TmVar(fi, current, check+shift)
let termShift = mapTerm termShift'

let termSubst' j s shift cutoff fi current check =
  if current=j+cutoff then termShift cutoff s
  else TmVar(fi, current, check)
let termSubst j s = mapTerm (termSubst' j s) s

let termSubstTop s t = termShift (-1) (termSubst 0 (termShift 1 s) t)

(*----------------------------------------------------------------------------
 * Evaluation
 *----------------------------------------------------------------------------*)

exception NoRuleApplies

let isval ctx t = match t with
    TmAbs(_,_,_) -> true
  | _ -> false

let rec eval' ctx t = match t with
    TmApp(fi, TmAbs(_, name, body), value) when isval ctx value ->
      termSubstTop value body
  | TmApp(fi, value, t2) when isval ctx value ->
      let t2' = eval' ctx t2
      in TmApp(fi, value, t2')
  | TmApp(fi, t1, t2) ->
      let t1' = eval' ctx t1
      in TmApp(fi, t1', t2)
  | _ -> raise NoRuleApplies

let rec eval ctx t =
  try let t' = eval' ctx t in eval ctx t'
  with NoRuleApplies -> t

(*----------------------------------------------------------------------------
 * Sample Terms
 *----------------------------------------------------------------------------*)

let sampleCtx = []

let sampleExpr =
  TmAbs(UNKNOWN, "x",
    TmAbs(UNKNOWN, "x",
      TmApp(UNKNOWN,
        TmVar(UNKNOWN, 2, 2),
        TmVar(UNKNOWN, 1, 2))))
