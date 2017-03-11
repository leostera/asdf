module Main

import Data.Vect

data Store : t -> Type where
  Create : (size : Nat) ->
           (elems : Vect size t) ->
           Store t

size : Store t -> Nat
size (Create size' elems') = size'

items : Store t -> Vect size t
items (Create size' elems') = elems'

addToStore : Store t -> t -> Store t

main : IO ()
main = ?main_rhs
