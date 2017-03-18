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
    (==) Solid Solid = True
    (==) Liquid Liquid = True
    (==) Gas Gas = True
    (==) _ _ = False
    {-
      (/=) x y = not (x == y)
      this definition is actually the default one,
      so no need to redefine it here
    -}

data Tree elem = Empty
               | Node (Tree elem) elem (Tree elem)
%name Empty empty
%name Node node, node1, node2
%name Tree tree, tree1, tree2

Eq (Tree elem) where
    (==) Empty Empty = ?Eq_rhs_1
    (==) Empty (Node tree x tree1) = ?Eq_rhs_4
    (==) (Node tree x tree1) y = ?Eq_rhs_3
