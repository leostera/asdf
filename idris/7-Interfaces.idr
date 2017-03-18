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
    (==) Solid Solid = ?Eq_rhs_1
    (==) Solid Liquid = ?Eq_rhs_6
    (==) Solid Gas = ?Eq_rhs_7
    (==) Liquid y = ?Eq_rhs_4
    (==) Gas y = ?Eq_rhs_5
    (/=) x y = ?Eq_rhs_2
