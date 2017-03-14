module Main

import Data.Vect

readVectLen : (len : Nat) -> IO (Vect len String)
readVectLen Z = pure []
readVectLen (S k) = do x <- getline
                       xs <- readVectLen k
                       pure (x :: xs)

main : IO ()
main = ?main_rhs
