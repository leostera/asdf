
import Test.QuickCheck

newtype Gen a = MkGen {
  unGen :: QCGen -> Int -> a
}
