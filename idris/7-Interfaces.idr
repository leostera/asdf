module Main

double : Num a => a -> a
double x = x*x

occurrences : (item : ty) -> (values : List ty) -> Nat
occurrences item [] = ?occurrences_rhs_1
occurrences item (x :: xs) = ?occurrences_rhs_2
