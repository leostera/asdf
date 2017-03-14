module Main

import Data.Vect

append' : Vect n elem -> Vect m elem -> Vect (n+m) elem
append' [] [] = ?append'_rhs_3
append' [] (x :: xs) = ?append'_rhs_4
append' (x :: xs) ys = ?append'_rhs_2
