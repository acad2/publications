import Data.Set

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

-- nextStep (succ, use, def, in, out) = (succ, use, def, in,out)
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
