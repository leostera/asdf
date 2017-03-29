module Main

import Data.Vect

{-
  This actually won't type check.

  Even though `a` is implementing the Decidable Equality interface,
  at some point the recursion _might_ end up calling `removeElem value []`
  which this function is not defined for (since [] is a Vect Z a).

  So there's really no guarantee that the value will appear in the vector,
  and thus it's possible to reach the end of the vector without ever finding it.

  Some options here would be:

  1. to consider the case for `[]`, and change the signature to return
     `Maybe (Vect n a)` -- if we reach the empty case, we might as well return
      Nothing.

  2. Return a dependant pair (length ** Vect lenght a) so we don't make an
     assumption on the length

  3. Have a type-level predicate that ensures that the element is in the vector
-}
removeElem : DecEq a => (value : a) -> (xs : Vect (S n) a) -> Vect n a
removeElem value (x :: xs) = case decEq value x of
                                  Yes prf => xs
                                  No contr => x :: removeElem value ?xs

{-
  Let's implement option 3 by defining a specific type that tells us that a
  given element is indeed part of the vector
-}

data Elem : a -> Vect k a -> Type where

  Here : Elem x (x :: xs) 
  There : (later : Elem x xs) -> Elem x (y :: xs) -- if x is in xs, it's also in y :: xs
