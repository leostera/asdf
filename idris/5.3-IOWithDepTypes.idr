module Main

import Data.Vect

readVectLen : (len : Nat) -> IO (Vect len String)
readVectLen Z = pure []
readVectLen (S k) = do x <- getLine
                       xs <- readVectLen k
                       pure (x :: xs)

data UnknownVect : Type -> Type where
  UVect : (len : Nat) -> Vect len a -> UnknownVect a

readUVect : IO (UnknownVect String)
readUVect = do x <- getLine
               if (x == "")
                  then pure (UVect _ [])
                  else do UVect _ xs <- readUVect
                          pure (UVect _ (x :: xs))

printVect : Show a => UnknownVect a -> IO ()
printVect (UVect len xs) = putStrLn (show xs ++ " (length " ++ show len ++ ")")

readVect : IO (len ** Vect len String)
readVect = do x <- getLine
              if (x == "")
                 then pure (_ ** [])
                 else do (_ ** xs) <- readVect
                         pure (_ ** x :: xs)

zipInputs : IO ()
zipInputs = do putStrLn "Enter vector #1 (blank line to end): "
               (len1 ** vec1) <- readVect
               putStrLn "Enter vector #2 (blank line to end): "
               (len2 ** vec2) <- readVect
               case exactLength len1 vec2 of
                    Nothing => do pure "Vector are of different length. Try again"
                                  zipInputs
                    Just vec2' => pure (zip vec1 vec2')

main : IO ()
main = ?main_rhs
