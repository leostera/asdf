open Core
open Core.Command
open In_channel

open Utils
open Shift_and
open Shift_or

let match_line algo pattern i line =
  match (algo pattern line) with
  | Hit(_, _, Position(_, column)) -> Hit(pattern, line, Position(i, column))
  | Miss(_,_) -> Miss(pattern, line)

let match_file algo pattern path =
  In_channel.read_lines path
  |> List.mapi ~f:(match_line algo pattern)

let print_matches file m =
  match m with
  | Miss(_,_) -> ()
  | Hit(pattern, ctx, Position(line, col)) ->
    Printf.printf "%s:%d:%d\t%s\n" file line col ctx

let run_one algo pattern file =
  match_file algo pattern file
  |> List.iter ~f:(print_matches file)

let run algo pattern files = List.iter ~f:(run_one algo pattern) files

let pick_algorithm = function
	| Some("sand") -> Some shift_and
	| Some("sor") -> Some shift_or
	| Some(_) -> None
	| None -> Some shift_and

let spec =
  let open Command.Spec in
  empty
	+> flag "-a" (optional string) ~doc:"name The algorithm name to use"
  +> anon ("pattern" %: string)
  +> anon (sequence ("filepath" %: string))

let command =
  Command.basic
    ~summary: "Find text in files"
    spec
		(fun algoName pattern paths () ->
			match pick_algorithm algoName with
			| Some(algo) -> run algo pattern paths
			| None -> eprintf "Unknown algorithm name"
		)

let () = Command.run ~version:"1.0" ~build_info:"WIP" command
