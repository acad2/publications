module Main where
import Control.Monad

main :: IO ()
main = do
	n <- readLn
	prog <- replicateM n getLine
	putStrLn.unlines.solve $ prog

solve :: [String] -> [String]
solve xs = concatMap trans xs++["d","d"]++xs

trans "b" = []
trans "s" = ["s"]
trans "d" = ["d","d","d"]
trans "h" = []