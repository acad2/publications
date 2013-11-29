data CompatibilityGraph nodes priority = CompatibilityGraph [nodes] [([nodes],priority)]
data ConnectionTable connection from to state = ConnectionTable [ConnectionRow connection from to state]
type ConnectionRow connection from to state = (connection,from,to,[state])

enrich :: [x] -> (x -> y) -> [(x,y)]
enrich [] _ = []
enrich (x:xs) f = ((x,f x) : enrich xs f)

calculateGreedyPartition :: (Eq node, Ord priority) => (CompatibilityGraph node priority) -> [[node]]
calculateGreedyPartition (CompatibilityGraph x []) = map (\a -> [a]) x
calculateGreedyPartition (CompatibilityGraph x y) = (vs:calculateGreedyPartition (CompatibilityGraph vr er)) where (vs,ls) = argmax y
                                                                                                                   vr = setminus x vs
                                                                                                                   er = significantEdges y vr

calculateIncompatibleConnections :: (Eq from, Eq state) => (ConnectionTable connection from to state) -> [(connection,connection)]
calculateIncompatibleConnections (ConnectionTable (r:rs)) = calculateIncompatibleConnectionRow r rs

calculateIncompatibleConnectionRow :: (Eq from, Eq state) => (ConnectionRow connection from to state) -> [(ConnectionRow connection from to state)] -> [(connection,connection)]
calculateIncompatibleConnectionRow _ [] = []
calculateIncompatibleConnectionRow (aa,ab,ac,ad) other = [(aa,ba)|(ba,bb,bc,bd) <- other]++(calculateIncompatibleConnectionRow y ys) where (y:ys) = other

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
