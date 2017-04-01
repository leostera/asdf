module Main

next : Nat -> Stream Nat
next n = (n :: Delay (next (S n)))

data InfIO : Type where
  Do : IO a -> (a -> Inf InfIO) -> InfIO

-- sugar me with do-notation
(>>=) : IO a -> (a -> Inf InfIO) -> InfIO
(>>=) = Do

-- First try, infinite IO with partial run

loopPrint : Nat -> () -> IO ()
loopPrint x = \_ => do putStrLn (show y) where
  y = x+1

