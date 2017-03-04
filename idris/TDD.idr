module TypeDrivenDevelopment

||| Map a list of strings to their length
allLengths : List String -> List Nat
allLengths xs = map length xs

||| Negate a boolean
invert : (t : Bool) -> Bool
invert True = False
invert False = True

||| Describe whether a list is empty or not
describeList : List Int -> String
describeList [] = "Empty"
describeList (x :: xs) = "Non-empty"

xor : Bool -> Bool -> Bool
xor False y = y
xor True y = not y

mutual
  isEven : Nat -> Bool
  isEven Z = True
  isEven (S k) = isOdd k

  isOdd : Nat -> Bool
  isOdd Z = False
  isOdd (S k) = isEven k
