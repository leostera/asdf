module Main

printLength : IO ()

main : IO ()
main = do
  putStr "Enter a name: "
  x <- getLine
  putStrLn ("Hello " ++ x ++ "!")
