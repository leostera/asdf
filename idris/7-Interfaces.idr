module Main

double : Num a => a -> a
double x = x*x

occurrences : Eq ty => (item : ty) -> (values : List ty) -> Nat
occurrences item [] = 0
occurrences item (value :: values) = case value == item of
                                          True => 1 + occurrences item values
                                          False => occurrences item values

data Matter = Solid | Liquid | Gas

Eq Matter where
    (==) x y = ?Eq_rhs_1
    (/=) x y = ?Eq_rhs_2
