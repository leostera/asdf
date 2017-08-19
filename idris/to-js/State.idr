module Sss

import Control.Monad.State

increase : Nat -> State Nat ()
increase k = do current <- get
                put (current + k)

