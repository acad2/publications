type TransitionTable a b = [TransitionEntry a b]
type TransitionEntry a b = (a,[a],b)

doTransition :: (Eq a) => TransitionTable a b -> a -> Int -> Maybe a
doTransition [] _ _ = Nothing
doTransition ((x,list,_):rest) a i	| a == x = Just (list!!i)
									| otherwise = doTransition rest a i

splitOutput :: (Eq b) => TransitionTable a b -> ([[a]],[b])
splitOutput [] = ([],[])
splitOutput ((x,_,b):rest) = addOrNew (splitOutput rest) x b

addOrNew :: (Eq b) => ([[a]],[b]) -> a -> b -> ([[a]],[b])
addOrNew ([],_) x y = ([[x]],[y])
addOrNew ((a:as),(b:bs)) x y	| y == b = (((x:a):as),(b:bs))
								| otherwise = ((a:cs),(b:ds)) where (cs,ds) = addOrNew (as,bs) x y

performSplitStep :: (Eq a, Eq b) => ([[a]],[b]) -> TransitionTable a b -> ([[a]],[b])

partitionate :: (Eq a) => [a] -> TransitionTable a b -> [[a]] -> ([[a]],[Int])
partitionate [] _ _ = ([],[])
partitionate [x] partitionTable list = ([x])


getFirstIndex :: [a] -> (a -> Bool) -> Int -> Int
getFirstIndex [] _ _ = -1
getFirstIndex (a:as) f i	| f a = i
							| otherwise = getFirstIndex as f (i+1)
