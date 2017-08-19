module Main

T : Type -> Type
T ty = () -> ty

f : { ty : Type } -> { auto prf : ty } -> ty -> ty
f { ty } v = v

g : { ty : Type } -> T ty
g { ty } = f { ty }
