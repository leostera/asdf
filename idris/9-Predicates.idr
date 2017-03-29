module Main

import Data.Vect

removeElem : DecEq a => (value : a) -> (xs : Vect (S n) a) -> Vect n a
removeElem value (x :: xs) = case decEq value x of
                                  Yes prf => xs
                                  No contr => ?removeElem_on_contra
