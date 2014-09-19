module Utils (replaceIth,mapIth,repeatN,rotateR) where

import qualified Data.Matrix as M

repeatN :: Int->(a->a)->a->a
repeatN 0 _ x = x
repeatN n f x = repeatN (n-1) f (f x)

replaceIth :: Int -> a -> [a] -> [a]
replaceIth 0 v (_:xs) = (v:xs)
replaceIth i v (x:xs) = x:replaceIth (i-1) v xs

mapIth :: Int -> (a -> a) -> [a] -> [a]
mapIth 0 f (x:xs) = (f x:xs)
mapIth i f (x:xs) = x:mapIth (i-1) f xs

rotateR :: [[a]] -> [[a]]
rotateR ([]:_) = []
rotateR x = reverse (map head x) : rotateR (map tail x)
