module Main

import Data.Vect

readVectLen : (len : Nat) -> IO (Vect len String)
readVectLen Z = ?readVectLen_rhs_4
readVectLen (S k) = ?readVectLen_rhs_2

main : IO ()
main = ?main_rhs
