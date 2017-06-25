open Format

(* filepath, line number, column number *)
type info = FI of string * int * int | UNKNOWN

type binding = NameBind
type context = (string * binding) list

type term =
  (* de Bruijn indexes: current and current index *)
    TmVar of info * int * int

  (* abstraction with function name and body *)
  | TmAbs of info * string * term

  (* function application *)
  | TmApp of info * term * term

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
          | None -> Printf.sprintf "Variable lookup failed: offset(%d), ctx size(%d)" current (ctxLength ctx)
      else
        Printf.sprintf
          "[bad idea! Context(%s) Current(%d) Consistency(%d)]"
          (printCtx ctx) current consistencyCheck

let printTerm ctx t = Printf.printf "%s" (printTerm' ctx t)

let sampleCtx = []

let sampleExpr =
  TmAbs(UNKNOWN, "x",
    TmAbs(UNKNOWN, "x",
      TmApp(UNKNOWN,
        TmVar(UNKNOWN, 2, 2),
        TmVar(UNKNOWN, 1, 2))))
