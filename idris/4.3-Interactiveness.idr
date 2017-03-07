module Main

import Data.Vect

data Store : t -> Type where
  Create : (size : Nat) ->
           (elems : Vect size t) ->
           Store

size : Store t -> Nat

main : IO ()
main = ?main_rhs
