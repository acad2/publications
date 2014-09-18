{-# LANGUAGE MultiParamTypeClasses #-}

import qualified Data.Set as S
import Debug.Trace

type Crd = (Int,Int)

hexarcs :: Crd -> [Crd]
hexarcs (x,y) = [(x-1,y),(x-1,y+1),(x,y+1),(x+1,y),(x+1,y-1),(x-1,y-1)]

hexmoves :: Crd -> [Crd]
hexmoves (x,y) | r == 1 = [(x+1,y),(x,y-1),(x-1,y+1)]
               | r == 2 = [(x-1,y),(x,y+1),(x+1,y-1)]
               | otherwise = []
               where r = (x+2*y) `mod` 3
               
class EvalCompare a where
    valueLess :: a -> a -> Bool

ordMerge :: (Ord a, EvalCompare a) => [a] -> [a] -> [a]    
ordMerge = ordMerge' S.empty

ordMerge' :: (Ord a, EvalCompare a) => S.Set a -> [a] -> [a] -> [a]
ordMerge' d [] ys = filter (\x -> S.notMember x d) ys
ordMerge' d xs [] = ordMerge' d [] xs
ordMerge' d (x:xs) (y:ys) | S.member x d = ordMerge' d xs (y:ys)
                          | S.member y d = ordMerge' d (x:xs) ys
                          | valueLess x y  = x:(ordMerge' (S.insert x d) xs (y:ys))
                          | otherwise = y:(ordMerge' (S.insert y d) (x:xs) ys)


data DijkstraPath a b = DP (a,[a],b) deriving Show

instance (Eq a) => Eq (DijkstraPath a b) where
    DP (a,_,_) == DP (b,_,_) = a == b

instance (Ord a) => Ord (DijkstraPath a b) where
    compare (DP (a,_,_)) (DP (b,_,_)) = compare a b

instance (Ord b) => EvalCompare (DijkstraPath a b) where
    valueLess (DP (_,_,va)) (DP (_,_,vb)) = va < vb

appendDijkstraPath :: (Num b) => DijkstraPath a b -> (a,b) -> DijkstraPath a b
appendDijkstraPath (DP (na,p,va)) (nb,vb) = DP (nb,(nb:p),va+vb)

dijkstra :: (Show a, Ord a,Num b,Ord b) => [a] -> [a] -> (a->[(a,b)]) -> ([a],b)
dijkstra s d f = dijkstra' (map (\x -> DP (x,[],fromInteger 0)) s) (S.fromList d) f

dijkstra' :: (Show a, Eq a,Ord a,Num b,Ord b) => [DijkstraPath a b] -> S.Set a -> (a->[(a,b)]) -> ([a],b)
dijkstra' (DP (n,p,b):ns) d f | S.member n d = (p,b)
                              | otherwise = dijkstra' ((ordMerge ns (map (appendDijkstraPath (DP (n,p,b))) (f n)))) d f
                              
honeyComb :: Crd -> Crd -> ([Crd],Int)
honeyComb a b = dijkstra (hexarcs a) (hexarcs b) (\x -> map (\y -> (y,1)) (hexmoves x))
