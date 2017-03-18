module Main

double : Num a => a -> a
double x = x*x

occurrences : (item : ty) -> (values : List ty) -> Nat
occurrences item values = ?occurrences_rhs
