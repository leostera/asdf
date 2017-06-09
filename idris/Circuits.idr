module Circuits

total
wiresIn : Nat -> Type
wiresIn Z = Type
wiresIn (S k) = Wire -> (wiresIn k)

data Box : (inputCount : Nat) -> Type where
  MkBox : (n : Nat) -> (wiresIn n) -> Box n

data Wire : Type where
  MkWire : Wire
