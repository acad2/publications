module Main where
import Data.List
import Data.Ord
import Control.Monad

main :: IO ()
main = do
	n <- readLn
	width <- readLn
	board <- replicateM n getLine
	putStrLn.show.solve width $board

solve :: Int -> [String] -> Int
solve width board = maximumBy (comparing (dropping board.subtract 1)) [1..width]

dropping :: [String] -> Int -> Double
dropping (line:board) column 
				|null board =  read.(:[]).(!! column) $ line
				|line!!column == '.' = dropping board column
				|column == 0 = dropping board (column+1)
				|column == (length line - 1) = dropping board (column - 1)
				|otherwise = dropping board (column+1) * 0.5 + dropping board (column-1) * 0.5