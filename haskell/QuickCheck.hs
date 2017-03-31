
import Test.QuickCheck
import Test.QuickCheck.Gen

newtype Gen a = MkGen {
  unGen :: QCGen -> Int -> a
}
