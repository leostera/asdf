import Data.Vect

total insert : Ord type => (x : type) -> (xsSorted : Vect len type) -> Vect (S len) type
insert x [] = [x]
insert x (y :: xs) = case x < y of
                          False => y :: insert x xs
                          True => x :: y :: xs

total insSort : Ord type => Vect length type -> Vect length type
insSort [] = []
insSort (x :: xs) = let xsSorted = insSort xs in
                              insert x xsSorted

total len : List a -> Nat
len [] = 0
len (x :: xs) = 1 + len xs

total rev : List a -> List a
rev [] = []
rev (x :: xs) = rev xs ++ [x]

total map' : (a -> b) -> List a -> List b
map' f [] = []
map' f (x :: xs) = f x :: map' f xs

total map'' : (a -> b) -> Vect n a -> Vect n b
map'' f [] = []
map'' f (x :: xs) = f x :: map'' f xs

map1 : (a -> b) -> Vect n a -> Vect n b
map1 f [] = []
map1 f (x :: xs) = ?map1_rhs_2

total rev1 : Vect n a -> Vect n a
rev1 [] = []
rev1 (x :: xs) = xs ++ x :: Nil
