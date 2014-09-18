module Utils (repeatN) where

repeatN :: Int->(a->a)->a->a
repeatN 0 _ x = x
repeatN n f x = repeatN (n-1) f (f x)
