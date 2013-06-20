--smart version
module Main where
import Data.List
import Data.Ord

main :: IO ()
main = do
	x <- readLn
	putStrLn.unwords.map show.solve $ x

solve :: Int -> [Int]
solve x |odd x = mid:merge [1..mid-1] [x,x-1..mid+1]
		|otherwise = merge (mid:[x,x-1..mid+1]) [1..mid-1] 
	where 
		mid = div x 2 + 1
		merge xs = concat.zipWith (\x y -> [x,y]) xs