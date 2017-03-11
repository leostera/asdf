module Main

import Data.Vect

data Store : t -> Type where
  Create : (size : Nat) ->
           (elems : Vect size t) ->
           Store t

size : Store t -> Nat
size (Create size' elems') = size'

items : Store t -> Vect size t
items x = ?items_rhs

main : IO ()
main = ?main_rhs
