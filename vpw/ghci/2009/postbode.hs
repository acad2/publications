--naive version
module Main where
import Data.List
import Data.Ord
main :: IO ()
main = do
	x <- readLn
	putStrLn.unwords.map show.solve $ x

solve :: Int -> [Int]
solve x = maximumBy (comparing dx) $ permutations [1..x]

dx :: [Int] -> Int
dx a= sum.map abs $ zipWith (-) (init a) (tail a)