module Main

import Data.Vect

append' : Vect n elem -> Vect m elem -> Vect (n+m) elem
append' [] ys = ?append'_rhs_1
append' (x :: xs) ys = ?append'_rhs_2
