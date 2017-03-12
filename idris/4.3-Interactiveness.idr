module Main

import Data.Vect

data Store : t -> Type where
  Create : (size : Nat) ->
           (elems : Vect size t) ->
           Store t

size : Store t -> Nat
size (Create size' elems') = size'

items : (store : Store t) -> Vect (size store) t
items (Create size' elems') = elems'

add : (store : Store t) -> t -> Store t
add (Create size elems) newElem = Create _ (addItem elems newElem)
  where
    addItem : Vect n t -> Vect (S n) t

main : IO ()
main = ?main_rhs
