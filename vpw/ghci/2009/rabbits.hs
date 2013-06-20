main :: IO ()
main = do
		l <- readLn
		u <- readLn
		print (solve l u)

solve :: Integer -> Integer -> Integer
solve l u = maximum (map maxPop [l..u])

maxPop :: Integer -> Integer
maxPop = maximum.(1:).takeWhile (>1).iterate next
--maxPop 1 = 1
--maxPop n = max n (maxPop (next n))

next :: Integer -> Integer
next n	| even n = n `div` 2
		| otherwise = 3*n+1
