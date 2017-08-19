module Main

import System
import System.Concurrency.Channels

Show PID where
  show (MkPID pid) = pid

main : IO ()
main = do pid <- spawn $ system "time" >>= \x => pure ()
          case pid of
               Just p => putStrLn $ show p
               Nothing => putStrLn "Failed to spawn"
