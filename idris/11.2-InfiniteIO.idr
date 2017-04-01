module Main


-- First try, infinite IO with partial run

data InfIO : Type where
  Do : IO a ->
       (a -> Inf InfIO) ->
       InfIO

loopPrint : String -> InfIO
loopPrint x = Do (putStrLn x)
                 (\_ => loopPrint x)

run : InfIO -> IO ()
run (Do x f) = do res <- x
                  run (f res)

-- Second try, infinite IO with total run

data Fuel : Type where
  Dry : Fuel
  More : Fuel -> Fuel

tank : Nat -> Fuel
tank Z = ?tank_rhs_1
tank (S k) = ?tank_rhs_2

main : IO ()
main = run $ loopPrint "hello world"
