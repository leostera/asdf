module Main

data InfIO : Type where
  Do : IO a ->
       (a -> Inf InfIO) ->
       InfIO

loopPrint : String -> InfIO
loopPrint x = Do (putStrLn x)
                 (\_ => loopPrint x)

run : InfIO -> IO ()
run x = ?run_rhs

main : IO ()
main = run $ loopPrint "hello world"
