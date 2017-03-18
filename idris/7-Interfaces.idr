module Main

double : Num a => a -> a
double x = x*x

occurrences : (item : ty) -> (values : List ty) -> Nat
occurrences item [] = 0
occurrences item (x :: xs) = case _ of
                                  case_val => ?occurrences_rhs_2
