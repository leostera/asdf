
let server = Ffi_micro.micro (fun _ -> fun _ -> "Hello world!")

let () = Ffi_micro.listen server 2112
