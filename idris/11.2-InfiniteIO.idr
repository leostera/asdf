module Main

data InfIO : Type where
  Do : IO a ->
       (a -> Inf InfIO) ->
       InfIO

loopPrint : String -> InfIO
loopPrint x = Do (putStrLn x)
                 (\_ => loopPrint x)

main : IO ()
main = ?run $ loopPrint "hello world"
