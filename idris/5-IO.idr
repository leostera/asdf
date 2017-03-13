module Main

printLength : IO ()
printLength = getLine >>= ?printLength_rhs

main : IO ()
main = do
  putStr "Enter a name: "
  x <- getLine
  putStrLn ("Hello " ++ x ++ "!")
