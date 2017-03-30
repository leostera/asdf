import Data.Vect

{-
data Range : (begin : Nat) -> (end : Nat) -> Type where
  EmptyRange : Range 0 0
  MkRange : (begin : Nat) -> (end: Nat) -> Range begin end

interface Encoding a where
  alphabet : Range n m
  digit : Range n m

Encoding ASCII where
  alphabet = MkRange 64 116
  digit = MkRange 48 60

Cast ASCII Char where
  cast (MkASCII n) = chr (cast n)
-}

data ASCII : Type where
  MkASCII : ASCII

data Unicode : Type where
  MkUnicode : Unicode

interface Encoding a where
  alphabet : a -> (Nat, Nat)
  upper : a -> (Nat, Nat)
  digits : a -> (Nat, Nat)


Encoding ASCII where
  alphabet MkASCII = (64, 116)
  upper MkASCII = (64, 66)
  digits MkASCII = (0, 9)

Encoding Unicode where
  alphabet MkUnicode = (0, 52)
  upper MkUnicode = (64, 66)
  digits MkUnicode = (100, 109)

inRangeProof : (Nat, Nat) -> Nat -> Type
inRangeProof (min, max) n = case (min <= n) && (n <= max) of
                                 True => Elem True [True]
                                 False => Elem False [True]

data Character : e -> Nat -> Type where
  Digit  : Encoding e =>
           (e' : e) ->
           (n : Nat) ->
           { auto inRange : inRangeProof (digits e') n } ->
           Character e' n

  Upper : Encoding e =>
          (e' : e) ->
          (n : Nat) ->
          { auto inRange : inRangeProof (upper e') n } ->
          Character e' n

  Letter  : Encoding e =>
            (e' : e) ->
            (n : Nat) ->
            { auto inRange : inRangeProof (alphabet e') n } ->
            Character e' n

isDigit : Character e n -> Nat
isDigit (Digit e n) = 0
isDigit (Upper e n) = 1
isDigit (Letter e n) = 2 
