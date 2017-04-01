module Main

next : Nat -> Stream Nat
next n = (n :: Delay (next (S n)))

data InfIO : Type where
  Do : IO a -> (a -> Inf InfIO) -> InfIO

-- sugar me with do-notation
(>>=) : IO a -> (a -> Inf InfIO) -> InfIO
(>>=) = Do

-- First try, infinite IO with partial run

loopPrint : Nat -> () -> InfIO
loopPrint x = \_ => do putStrLn (show x)
                       loopPrint (S x)

run : InfIO -> IO ()
run (Do x f) = do res <- x
                  run (f res)

-- Second try, finine infinite IO with total run

data Fuel : Type where
  Dry : Fuel
  More : Fuel -> Fuel

tank : Nat -> Fuel
tank Z = Dry
tank (S k) = More (tank k)

total runTank : Fuel -> InfIO -> IO ()
runTank Dry _ = putStrLn "Out of Fuel"
runTank (More fuel) (Do c f) = do res <- c
                                  runTank fuel (f res)

-- Third try, Lazy Fuel for infinite infinite IO with a total run

data Gas : Type where
  Empty : Gas
  Some : Lazy Gas -> Gas

data Run : Type where
  Stop : Run
  Step : Lazy Run -> Run

total runEngine : Gas -> InfIO -> IO ()
runEngine Empty y = putStrLn "Out of fuel"
runEngine (Some x) (Do y f) = y >>= \res => runEngine x (f res)

freeGas : Gas
freeGas = Some freeGas

main : IO ()
main = runEngine freeGas (loopPrint 0)
