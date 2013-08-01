enrich :: [x] -> (x -> y) -> [(x,y)]
enrich [] _ = []
enrich (x:xs) f = ((x,f x) : enrich xs f)

calculatePartition :: [v] -> [([v],l)] -> [[v]]
calculatePartition x [] = map (\a -> [a]) x
calculatePartition x y = (vs:) where (vs,ls) = argmax y

argmax :: (Ord y) => [(x,y)] -> (x,y)
argmax (x:xs) = argmax' x xs

argmax' :: (Ord y) => (x,y) -> [(x,y)] -> (x,y)
argmax' x [] = x
argmax' (x,y) ((xa,ya):zs) | ya > y = argmax' (xa,ya) zs
                           | otherwise = argmax' (x,y) zs
