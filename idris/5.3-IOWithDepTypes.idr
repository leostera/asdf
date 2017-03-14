module Main

import Data.Vect

readVectLen : (len : Nat) -> IO (Vect len String)
readVectLen Z = pure []
readVectLen (S k) = do x <- getLine
                       xs <- readVectLen k
                       pure (x :: xs)

data UVect : Type -> Type where
  UVect : (len : Nat) -> Vect len a -> UVect a

main : IO ()
main = ?main_rhs
