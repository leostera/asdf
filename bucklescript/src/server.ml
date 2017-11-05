open Express

let handle_get str _ r = send ~res:r str

let () =
  express ()
  |> get ~path:"/" ~cb:(handle_get "root!")
  |> get ~path:"/what" ~cb:(handle_get "some other path")
  |> listen ~port:2112
