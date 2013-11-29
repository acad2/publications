main :: IO()
main = do
	k <- readLn
	putStr (solve k);

solve :: Int -> String
solve 1 = "* *\n * \n* *\n"
solve k = tb++
			concatMap (solveB k) [0..k-3]++
			itb++
			cp++
			c++
			cp++
			itb++
			concatMap (solveF k) [0..k-3]++
			tb
           where tb = solveA k
                 itb = solveC k;
                 cp = solveD k;
                 c = concat.replicate (k-2).solveE $ k
-- ++(solveC k)++(solveD k)++(solveE k)++(solveD k)++(solveC k)++(solveB k)++

solveA :: Int -> String
solveA k = "*"++dashes (k-2)++"*"++spaces k++"*"++dashes (k-2)++"*\n";

solveB :: Int -> Int -> String
solveB k j = "|"++spaces (k-3-j)++"/"++spaces (k+2+2*j)++"\\"++spaces (k-3-j)++"|\n";

solveC :: Int -> String
solveC k = "*"++spaces (3*k-2)++"*\n";

solveD :: Int -> String
solveD k = spaces k++"*"++dashes (k-2)++"*"++spaces k++"\n";

solveE :: Int -> String
solveE k = spaces k++"|"++spaces (k-2)++"|"++spaces k++"\n";

solveF :: Int -> Int -> String
solveF k j = "|"++spaces j++"\\"++spaces (3*k-2*j-4)++"/"++spaces j++"|\n";

spaces = flip replicate ' '
dashes = flip replicate '-'