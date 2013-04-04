import Data.Set

data Vars = t1 | t2 | t3 | t4 | t5 | t6 | t7 | t8 | t9 | t10 | t11
data Funs = abs1 | abs2 | max1 | min | shr3 | shr1 | sub | add | max2
data Cons = in1 | in2 | out1

succ0 :: [[Int]]
succ0 = [[0,1],[2],[3],[4],[5],[6],[7],[0]]

use0 :: [Set Char]
use0 = [fromList "",fromList "ab",fromList "cd",fromList "ef",fromList "eg",fromList "hi",fromList "ej",fromList "k"]

def0 :: [Set Char]
def0 = [fromList "ab",fromList "cd",fromList "ef",fromList "gh",fromList "i",fromList "j",fromList "k",fromList ""]

in0 :: [Set Char]
in0 = [fromList "",fromList "",fromList "",fromList "",fromList "",fromList "",fromList "",fromList ""]

out0 :: [Set Char]
out0 = [fromList "",fromList "",fromList "",fromList "",fromList "",fromList "",fromList "",fromList ""]

vars0 :: [Char]
vars0 = "abcdefghijk";

fun0 :: [Char]
fun0 = "012345678";

mergefun0 :: [Set Char]
mergefun0 = [fromList "67", fromList "28"];

conn0 :: [(Char,Char,Integer)]
conn0 = [('a','0',0),('b','1',0),('c','2',0),('c','3',0),('e','4',0),('e','6',0),('e','8',0),('f','5',0),('h','7',0),('d','2',1),('d','3',1),('g','6',1),('h','7',1),('i','8',1),('c','0',2),('d','1',2),('e','2',2),('f','3',2),('g','4',2),('h','5',2),('i','6',2),('j','7',2),('k','8',2)];

-- finalInOut (succ, use, def, in, out) = (in, out)
finalInOut :: (Ord v) => ([[Int]],[Set v],[Set v],[Set v],[Set v]) -> ([Set v],[Set v])
finalInOut inp = (ins2,out2)
  where (_,_,_,ins2,out2) = fixedPoint nextStep inp

-- nextStep (succ, use, def, in, out) = (succ, use, def, in, out)
nextStep :: (Ord v) => ([[Int]],[Set v],[Set v],[Set v],[Set v]) -> ([[Int]],[Set v],[Set v],[Set v],[Set v])
nextStep (succ, use, def, ins, out) = (succ, use, def, ins2,(nextOut succ ins2))
			where ins2 = (nextIn use def out)

-- nextIn (use, def, out)
nextIn :: (Ord v) => [Set v] -> [Set v] -> [Set v] -> [Set v]
nextIn [] _ _ = []
nextIn (u:us) (d:ds) (o:os) = (union u (difference o d)):(nextIn us ds os)

-- nextOut (succ,in)
nextOut :: (Ord v) => [[Int]] -> [Set v] -> [Set v]
nextOut [] _ = []
nextOut (s:ss) ins = (unions [ins!!x | x <- s]) : (nextOut ss ins)

fixedPoint :: (Eq a) => (a -> a) -> a -> a
fixedPoint f x | x2 == x = x
               | otherwise = fixedPoint f x2
                 where x2 = (f x)
                 
clashVariables :: (Ord v) => [Set v] -> [(v,v)]
clashVariables ins = [(a,b)| a <- total, b <- total, a < b, clash ins a b] where total = elems (unions ins)

clash :: (Ord v) => [Set v] -> v -> v -> Bool
clash ins a b = any (\x -> (member a x) && (member b x)) ins

priority :: (Ord f, Ord v, Eq c) => [v] -> [(v,f,c)] -> [Set f] -> [(v,v,Int)]
priority vars conns mergefus = [(v1,v2,coconns mergefus conns v1 v2) | v1 <- vars, v2 <- vars, v1 < v2, (coconns mergefus conns v1 v2) /= 0]

coconns :: (Ord f, Eq v, Eq c) => [Set f] -> [(v,f,c)] -> v -> v -> Int
coconns [] _ _ _ = 0
coconns (sf : sfs) list v1 v2 = (length [1|(va,fa,ca) <- list, va == v1, member fa sf, (vb,fb,cb) <- list, vb == v2, ca == cb, member fb sf])+(coconns sfs list v1 v2)
