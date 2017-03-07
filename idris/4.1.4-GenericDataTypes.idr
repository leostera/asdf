data Option a = None | Some a

total safeDiv : Double -> Double -> Option Double
safeDiv x 0.0 = None
safeDiv x y = Some (x/y)

data Result a b = Ok a | Error b

total run : (f : (a -> c)) -> (g : (b -> c)) -> Result a b -> c
run f g (Ok x) = f x
run f g (Error x) = g x

data Tree elem = Empty
               | Node (Tree elem) elem (Tree elem)
%name Tree tree, tree1

insert : Ord elem => elem -> Tree elem -> Tree elem
insert x Empty = Node Empty x Empty
insert x (Node left val right) = compare x val
