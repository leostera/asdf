module Main

import Data.Vect

{-
  This actually won't type check.

  Even though `a` is implementing the Decidable Equality interface,
  at some point the recursion might end up calling `removeElem value []`
  which this function is not defined for (since [] is a Vect Z a).

  So there's really no guarantee that the value will appear in the vector,
  and thus it's possible to reach the end of the vector without ever finding it.

  Some options here would be

  1. to consider the case for `[]`, and change the signature to return
     `Maybe (Vect n a)` -- if we reach the empty case, we might as well return
      Nothing.

  2. Return a dependant pair (length ** Vect lenght a) so we don't make an
     assumption on the length

  3. Have a type-level predicate that ensures that the element is in the vector
-}
removeElem__nope : DecEq a => (value : a) -> (xs : Vect (S n) a) -> Vect n a
removeElem__nope value (x :: xs) = case decEq value x of
                                  Yes prf => xs
                                  No contr => ?x_removeElem_value_xs

{-
  Let's implement option 3 by defining a specific type that tells us that a
  given element is indeed part of the vector

  Elem is actually already part of Data.Vect, so here it's defined as Elem'
  but we'll use Data.Vect.Elem instead
-}

data Elem' : a -> Vect k a -> Type where
  -- x is the first value of the vector
  Here : Elem' x (x :: xs)

  -- if x is in xs, it's also in y :: xs
  There : (later : Elem' x xs) -> Elem' x (y :: xs)

oneInVector : Elem 1 [1,2,3]
oneInVector = Here

somewhereElseInVector : Elem 1 [2,3,1]
somewhereElseInVector = There (There Here)

notInVector : Elem 1 [3,4]
notInVector = There (There ?notInVector_rhs2)

removeElemWithProof : (value : a) ->
                      (xs : Vect (S n) a ) ->
                      (prf : Elem value xs) ->
                      Vect n a
removeElemWithProof value (value :: ys) Here = ys
removeElemWithProof { n = Z } value (y :: []) (There later) = absurd later
removeElemWithProof { n = (S k) } value (y :: ys) (There later) =
  y :: removeElemWithProof value ys later

removeAutoProofed : (value : a) ->
                    (xs : Vect (S n) a) ->
                    {auto prf : Elem value xs} ->
                    Vect n a
removeAutoProofed value xs {prf} = removeElemWithProof value xs prf

removeElem : (value : a) ->
             (xs : Vect (S n) a) ->
             {auto prf : Elem value xs} ->
             Vect n a
removeElem value (value :: ys) { prf = Here  } = ys
removeElem { n = Z } value (y :: []) { prf = There later } = absurd later
removeElem { n = (S k) } value (y :: ys) { prf = There later } =
  y :: removeElem value ys

{-
  Now let's try to make a Letter data type that will only accept being
  constructed with alpha characters
-}


alphabet : Vect 52 String
alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

-- String implements DecEq
isAlphaProof : (value : String) -> Dec (Elem value (Vect 52 String))
isAlphaProof x = isElem x alphabet
