open Micro

let server = micro (fun _ -> fun _ -> "Hello world!")

let () = listen server 2112
