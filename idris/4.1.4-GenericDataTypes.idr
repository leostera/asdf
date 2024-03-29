data Option a = None | Some a

total safeDiv : Double -> Double -> Option Double
safeDiv x 0.0 = None
safeDiv x y = Some (x/y)

data Result a b = Ok a | Error b

total run : (f : (a -> c)) -> (g : (b -> c)) -> Result a b -> c
run f g (Ok x) = f x
run f g (Error x) = g x

data BSTree : Type -> Type where
  Empty : Ord elem => BSTree elem
  Node : Ord elem => (left : BSTree elem) ->
                     (val : elem) ->
                     (right : BSTree elem) ->
                     BSTree elem

insert : elem -> BSTree elem -> BSTree elem
insert x Empty = Node Empty x Empty
insert x orig@(Node left val right) = case compare x val of
                                      LT => Node (insert x left) val right
                                      EQ => orig
                                      GT => Node left val (insert x right)
