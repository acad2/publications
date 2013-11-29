import Data.List

data Board = Board [[Field]] deriving Show
data Field = O|X|E deriving Eq
data BoardTree = BoardTree Board [BoardTree] deriving Show

instance Eq Board where
	Board ba == Board bb = (bEq ba bb)

instance Show Field where
	show O = "O"
	show X = "X"
	show E = " "

bEq :: [[Field]] -> [[Field]] -> Bool
bEq fa fb = fa == fb || fa == rotate fb || fa == rotateN fb 2 || fa == rotateN fb 3 || fa == (reverse fb) || fa == reverse (rotate fb) || fa == reverse (rotateN fb 2) || fa == reverse (rotateN fb 3)

neg :: Field -> Field
neg O = X
neg X = O

genNextGen :: Board -> Int -> Field -> BoardTree
genNextGen b 0 _ = BoardTree b []
genNextGen b n f = BoardTree b [genNextGen x (n-1) (neg f)|x <- put b f]

put :: Board -> Field -> [Board]
put (Board r) f | isFinal (r) = []
		| otherwise =  nub (put2 [] r f)

put2 :: [[Field]] -> [[Field]] -> Field -> [Board]
put2 before [row] f = (putTemp before row [] f)
put2 before (row:after) f = (putTemp before row after f)++(put2 (before++[row]) after f)

putTemp :: [[Field]] -> [Field] -> [[Field]] -> Field -> [Board]
putTemp before row after put = nub (map (\x->Board (before++[x]++after)) (putRow row [] put))

putRow :: [Field] -> [Field] -> Field -> [[Field]]
putRow [] _ _ = []
putRow (x:xs) y f	| x == E = (y++(f:xs)):putRow xs (y++[x]) f
			| otherwise = putRow xs (y++[x]) f

rotate :: [[a]] -> [[a]]
rotate [] = []
rotate [x] = [[xi]|xi <- x]
rotate (x:xs) = zipWith (++) (rotate xs) ([[xi]|xi <- x])

rotateN :: [[a]] -> Int -> [[a]]
rotateN x 0 = x
rotateN x n = rotateN (rotate x) (n-1)

isFinal :: [[Field]] -> Bool
isFinal _ = False
