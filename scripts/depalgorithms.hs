import Data.List
import Data.Function

type Transition s i = s->i->s
type MooreOutput s o = s->o
type MealyOutput s i o = s->i->o
data MooreMachine s i o = Moore ([s],s,[i],[o],Transition s i,MooreOutput s o)
data MealyMachine s i o = Mealy ([s],s,[i],[o],Transition s i,MealyOutput s i o)

splitMooreOutput :: (Eq o) => MooreMachine s i o -> [[s]]
splitMooreOutput (Moore (states,_,_,_,_,func))  = partitionBy (mooreOutputSplitter func) states

mooreOutputSplitter :: (Eq b) => (a->b)->[a]->a->Bool
mooreOutputSplitter _ [] _ = False
mooreOutputSplitter func (x:xs) y = (func x) == (func y)

doSplitMooreOperation :: (Eq s) => MooreMachine s i o -> [[s]] -> [[s]] -> [[s]]
doSplitMooreOperation (Moore (_,_,inputs,_,transit,_)) = doSplitOperation inputs transit

doSplitMealyOperation :: (Eq s) => MealyMachine s i o -> [[s]] -> [[s]] -> [[s]]
doSplitMealyOperation (Mealy (_,_,inputs,_,transit,_)) = doSplitOperation inputs transit

doSplitOperation :: (Eq s) => [i] -> Transition s i -> [[s]] -> [[s]] -> [[s]]
doSplitOperation _ _ _ [] = []
doSplitOperation inputs transit partit (a:as) = (partitionBy (samePartition transit partit inputs) a)++(doSplitOperation inputs transit partit as)

samePartition :: (Eq s) => Transition s i -> [[s]] -> [i] -> [s] -> s -> Bool
samePartition _ _ _ [] _ = False
samePartition trans part inputs (first:_) state = all (\i -> (samePartitionStates part (trans first i) (trans state i))) inputs

samePartitionStates :: (Eq s) => [[s]] -> s -> s -> Bool
samePartitionStates [] _ _ = False
samePartitionStates (s:other) x y	| elem x s = elem y s
					| otherwise = samePartitionStates other x y

splitMealyOutput :: (Eq o) => MealyMachine s i o -> [[s]]
splitMealyOutput (Mealy (states,_,inputs,_,_,func))  = partitionBy (mealyOutputSplitter func inputs) states

mealyOutputSplitter :: (Eq b) => (a->i->b)->[i]->[a]->a->Bool
mealyOutputSplitter _ _ [] _ = False
mealyOutputSplitter func list (x:xs) y = all (\i -> ((func x i) == (func y i))) list

partitionBy :: ([a]->a->Bool)->[a]->[[a]]
partitionBy _ [] = []
partitionBy func (a:as) = addOrCreate func a (partitionBy func as)

addOrCreate :: ([a]->a->Bool)->a->[[a]] -> [[a]]
addOrCreate _ x [] = [[x]]
addOrCreate func x (l:ls)	| func l x = ((x:l):ls)
				| otherwise = (l:addOrCreate (func) x ls)

whileFunc :: ([a] -> [a]) -> [a] -> [[a]] 
whileFunc f a = map (snd) (takeWhile (uncurry ((/=) `on` length)) $ zip t (tail t))
	where 
		t = (iterate f a)

rebindMoore :: MooreMachine s i o -> [[s]] -> MooreMachine s i o
rebindMealy :: MealyMachine s i o -> [[s]] -> MealyMachine s i o

sampleMoore :: MooreMachine Char Char Char
sampleMoore = Moore (['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O'],'A',['0','1'],['0','1'],sampleMooreTransition,sampleMooreOutput)

sampleMooreTransition :: Transition Char Char
sampleMooreTransition 'A' '0' = 'B'
sampleMooreTransition 'A' '1' = 'C'
sampleMooreTransition 'B' '0' = 'D'
sampleMooreTransition 'B' '1' = 'E'
sampleMooreTransition 'C' '0' = 'F'
sampleMooreTransition 'C' '1' = 'G'
sampleMooreTransition 'D' '0' = 'H'
sampleMooreTransition 'D' '1' = 'I'
sampleMooreTransition 'E' '0' = 'J'
sampleMooreTransition 'E' '1' = 'K'
sampleMooreTransition 'F' '0' = 'L'
sampleMooreTransition 'F' '1' = 'M'
sampleMooreTransition 'G' '0' = 'N'
sampleMooreTransition 'G' '1' = 'O'
sampleMooreTransition 'H' '0' = 'H'
sampleMooreTransition 'H' '1' = 'I'
sampleMooreTransition 'I' '0' = 'J'
sampleMooreTransition 'I' '1' = 'K'
sampleMooreTransition 'J' '0' = 'L'
sampleMooreTransition 'J' '1' = 'M'
sampleMooreTransition 'K' '0' = 'N'
sampleMooreTransition 'K' '1' = 'O'
sampleMooreTransition 'L' '0' = 'H'
sampleMooreTransition 'L' '1' = 'I'
sampleMooreTransition 'M' '0' = 'J'
sampleMooreTransition 'M' '1' = 'K'
sampleMooreTransition 'N' '0' = 'L'
sampleMooreTransition 'N' '1' = 'M'
sampleMooreTransition 'O' '0' = 'N'
sampleMooreTransition 'O' '1' = 'O'

sampleMooreOutput :: MooreOutput Char Char
sampleMooreOutput 'J' = '1'
sampleMooreOutput _ = '0'

sampleMealy :: MealyMachine Char Char Char
sampleMealy = Mealy (['A','B','C','D','E','F','G'],'A',['0','1'],['0','1'],sampleMealyTransition,sampleMealyOutput)

sampleMealyTransition :: Transition Char Char
sampleMealyTransition 'A' '0' = 'B'
sampleMealyTransition 'A' '1' = 'C'
sampleMealyTransition 'B' '0' = 'D'
sampleMealyTransition 'B' '1' = 'E'
sampleMealyTransition 'C' '0' = 'F'
sampleMealyTransition 'C' '1' = 'G'
sampleMealyTransition 'D' '0' = 'D'
sampleMealyTransition 'D' '1' = 'E'
sampleMealyTransition 'E' '0' = 'F'
sampleMealyTransition 'E' '1' = 'G'
sampleMealyTransition 'F' '0' = 'D'
sampleMealyTransition 'F' '1' = 'E'
sampleMealyTransition 'G' '0' = 'F'
sampleMealyTransition 'G' '1' = 'G'

sampleMealyOutput :: MealyOutput Char Char Char
sampleMealyOutput 'E' '0' = '1'
sampleMealyOutput _ _ = '0'
