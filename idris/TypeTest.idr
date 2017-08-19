module Main

T : Type -> Type
T ty = () -> ty

f : (ty : Type) -> ty -> { auto prf : Maybe ty } -> ty
f ty v = \() => v

g : (ty : Type) -> T ty
