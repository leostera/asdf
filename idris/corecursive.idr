module Corecursive

import Control.Isomorphism

mutual
  data A = MkA B
  data B = MkB A

interface Isomorphism a b where

  iso : Either a b -> Either a b
