module Main

printLength : IO ()
printLength = getLine >>= \line => let len = show (length line) in putStrLn len

main : IO ()
main = do
  putStr "Enter a name: "
  x <- getLine
  putStrLn ("Hello " ++ x ++ "!")
