module Main

import Data.Vect

append' : Vect n elem -> Vect m elem -> Vect (n+m) elem

tri : Vect 3 (Double, Double)
tri = [(0.0, 0.0), (3.0, 0.0), (0.0, 4.0)]

Position : Type
Position = (Double, Double)

quad : Vect 4 Position

Polygon : Nat -> Type
Polygon n = Vect n Position

quint : Polygon 5
quint = ?quint_rhs

StringOrInt : Bool -> Type
StringOrInt False = String
StringOrInt True  = Int

getStringOrInt : (isInt : Bool) -> StringOrInt isInt
getStringOrInt False = "Ninety nine"
getStringOrInt True  = 99

stringify : (isInt : Bool) -> StringOrInt isInt -> String
stringify False x = trim x
stringify True  x = cast x

valToString : (isInt : Bool) ->
              (
                case isInt of
                     True => Int
                     False => String
              ) ->
              String

AdderType : (numargs : Nat) -> Type -> Type
AdderType Z numType = numType
AdderType (S k) numType =  (next : numType) -> AdderType k numType

adder : Num numType =>
        (numargs : Nat) -> numType -> AdderType numargs numType
adder Z acc = acc
adder (S k) acc = \next => adder k (next + acc)

data Format = Number Format
            | Str Format
            | Lit String Format
            | End

PrintfType : Format -> Type
PrintfType (Number x) = ?PrintfType_rhs_1
PrintfType (Str x) = ?PrintfType_rhs_2
PrintfType (Lit x y) = ?PrintfType_rhs_3
PrintfType End = ?PrintfType_rhs_4

