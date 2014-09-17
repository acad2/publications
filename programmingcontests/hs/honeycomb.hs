type Crd = (Int,Int)

hexmoves :: Crd -> [Crd]
hexmoves (x,y) | even x == even x+y = [(x+1,y),(x,y-1),(x-1,y+1)]
               | otherwise = [(x-1,y),(x,y+1),(x+1,y-1)]

dijkstra :: (Eq a,Num b,Ord b,Bounded b) => [a] -> [a] -> (a->([a],b)) -> ([a],b)
dijkstra s d f = dijkstra' (\x -> (x,minbound )) s

--dijkstra' :: (Eq a,Num b,Ord b,Bounded b) => [(a,b)] -> [a] -> (a->([a],b)) -> ([a],b)
