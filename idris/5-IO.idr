module Main

printLength : IO ()
printLength = getLine >>= \line => ?printLength_rhs

main : IO ()
main = do
  putStr "Enter a name: "
  x <- getLine
  putStrLn ("Hello " ++ x ++ "!")
