
type res
type req
type server

external listen : server -> int -> unit = "listen" [@@bs.send]
external micro : (req -> res -> string) -> server = "micro" [@@bs.module]
