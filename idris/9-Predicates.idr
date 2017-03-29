module Main

import Data.Vect

{-
  This actually won't type check. 
-}
removeElem : DecEq a => (value : a) -> (xs : Vect (S n) a) -> Vect n a
removeElem value (x :: xs) = case decEq value x of
                                  Yes prf => xs
                                  No contr => x :: removeElem value xs
