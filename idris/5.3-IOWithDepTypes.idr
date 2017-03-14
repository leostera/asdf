module Main

import Data.Vect

readVectLen : (len : Nat) -> IO (Vect len String)
readVectLen Z = pure []
readVectLen (S k) = do x <- getLine
                       xs <- readVectLen k
                       pure (x :: xs)

data UnknownVect : Type -> Type where
  UVect : (len : Nat) -> Vect len a -> UnknownVect a

readUVect : IO (UnknownVect String)
readUVect = do x <- getLine
               if (x == "")
                  then pure (UVect _ [])
                  else do UVect _ xs <- readUVect
                          pure (UVect _ (x :: xs))

printVect : Show a => UnknownVect a -> IO ()

main : IO ()
main = ?main_rhs
