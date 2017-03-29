module Main

import Data.Vect

{-
  This actually won't type check.

  Even though `a` is implementing the Decidable Equality interface,
  at some point the recursion _might_ end up calling `removeElem value []`
  which this function is not defined for (since [] is a Vect Z a).

  So there's really no guarantee that the value will appear in the vector,
  and thus it's possible to reach the end of the vector without ever finding it.

  Some options here would be to consider the case for `[]`, and change the
  signature to return `Maybe (Vect n a)` -- if we reach the empty case, we
  might as well return Nothing.
-}
removeElem : DecEq a => (value : a) -> (xs : Vect (S n) a) -> Vect n a
removeElem value (x :: xs) = case decEq value x of
                                  Yes prf => xs
                                  No contr => x :: removeElem value ?xs
