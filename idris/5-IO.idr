module Main

printLength : IO ()
printLength = ?printLength_rhs

main : IO ()
main = do
  putStr "Enter a name: "
  x <- getLine
  putStrLn ("Hello " ++ x ++ "!")
