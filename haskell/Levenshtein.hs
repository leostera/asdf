module Levenshtein where

levenshtein :: String -> String -> Int
levenshtein "" b = 0
levenshtein a "" = 0
levenshtein a b = compare a b + levenshtein (tail a) (tail b) where
  compare a b = if head a == head b then 0 else 1
