module Main

import Data.Vect

append' : Vect n elem -> Vect m elem -> Vect (n+m) elem
append' [] [] = []
append' (x :: xs) (y :: ys) = x :: append' xs (y :: ys)
