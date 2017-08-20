module Main

total
T : Type -> Type
T a = a -> a

f : String -> { ty : Type } -> { auto prf : ty } -> ty
f n a = a

g : { ty : Type } -> T ty
g { ty } = f "what" { ty = (T ty) } 
