
type app
type req
type res

type handler = (req -> res -> res)

external _listen : app -> int -> unit = "listen" [@@bs.send]
external _get : app -> string -> handler -> app = "get" [@@bs.send]
external _send : res -> string -> res = "send" [@@bs.send]

let listen app ~port = _listen app port
let get app ~path ~cb = _get app path cb
let send ~res body = _send res body

external express : unit -> app = "express" [@@bs.module]
