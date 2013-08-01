data  i [o]

enrich :: [x] -> (x -> y) -> [(x,y)]
enrich [] _ = []
enrich (x:xs) f = ((x,f x) : enrich xs f)

calculatePartition :: (Ord l, Eq v) => [v] -> [([v],l)] -> [[v]]
calculatePartition x [] = map (\a -> [a]) x
calculatePartition x y = (vs:calculatePartition vr er) where (vs,ls) = argmax y
                                                             vr = setminus x vs
                                                             er = significantEdges y vr

setminus :: (Eq a) => [a] -> [a] -> [a]
setminus a b = [x|x <- a, notElem x b]

significantEdges :: (Eq a) => [([a],b)] -> [a] -> [([a],b)]
significantEdges e c = [(x,y)|(x,y)<-e,all (\z -> elem z c) x]

argmax :: (Ord y) => [(x,y)] -> (x,y)
argmax (x:xs) = argmax' x xs

argmax' :: (Ord y) => (x,y) -> [(x,y)] -> (x,y)
argmax' x [] = x
argmax' (x,y) ((xa,ya):zs) | ya > y = argmax' (xa,ya) zs
                           | otherwise = argmax' (x,y) zs
