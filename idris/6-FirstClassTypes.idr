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

data Format = Character Format
            | Float Format
            | Number Format
            | Str Format
            | Lit String Format
            | End

PrintfType : Format -> Type
PrintfType (Character fmt) = (c : Char) -> PrintfType fmt
PrintfType (Float fmt) = (d : Float) -> PrintfType fmt
PrintfType (Number fmt) = (i : Int) -> PrintfType fmt
PrintfType (Str fmt) = (s : String) -> PrintfType fmt
PrintfType (Lit _ fmt) = PrintfType fmt
PrintfType End = String

printfFmt : (fmt : Format) -> (acc : String) -> PrintfType fmt
printfFmt (Character fmt) acc = \c => printfFmt fmt (acc ++ show c)
printfFmt (Float fmt) acc = \d => printfFmt fmt (acc ++ show d)
printfFmt (Lit lit fmt) acc = printfFmt fmt (acc ++ lit)
printfFmt (Number fmt) acc = \i => printfFmt fmt (acc ++ show i)
printfFmt (Str fmt) acc = \str => printfFmt fmt (acc ++ str)
printfFmt End acc = acc

toFormat : (xs : List Char) -> Format
toFormat [] = End
toFormat ('%' :: 'c' :: chars) = Character (toFormat chars)
toFormat ('%' :: 'd' :: chars) = Number (toFormat chars)
toFormat ('%' :: 'f' :: chars) = Float (toFormat chars)
toFormat ('%' :: 's' :: chars) = Str (toFormat chars)
toFormat (c :: chars) = case toFormat chars of
                             Lit lit chars' => Lit (strCons c lit) chars'
                             fmt => Lit (strCons c "") fmt

printf : (fmt : String) -> PrintfType (toFormat (unpack fmt))
printf fmt = printfFmt _ ""

Matrix : Num t => (n : Nat) -> (m : Nat) -> (t : Type) -> Type
Matrix n m t = Vect n (Vect m t)

testMatrix : Matrix 2 3 Double
testMatrix = [[0.0, 0.0, 0.0],
              [0.0, 0.0, 0.0]]

TupleVect : (n : Nat) -> (t : Type) -> Type
TupleVect Z t = ()
TupleVect (S k) t = (t, TupleVect k t)

testTupleVect : TupleVect 4 Nat
testTupleVect = (1,2,3,4,())

Pair : (Nat, (Nat, ()))
