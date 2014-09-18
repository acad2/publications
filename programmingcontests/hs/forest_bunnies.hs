module Main(main) where
import Utils (repeatN)

type BunnyState = (Int,Int,Int)

next15 :: BunnyState -> BunnyState
next15 (a,b,c) = (9*c `div` 10,a,(7*b `div` 10)+c)

next30 :: BunnyState -> BunnyState
next30 a = (3*x `div` 4,3*y `div` 4,3*z `div` 4) where (x,y,z) = next15 (next15 a)

forestbunnies :: Int -> Int
forestbunnies a = x+y+z where (x,y,z) = repeatN 12 next30 (0,0,a)

main :: IO ()
main = do
    x <- getLine
    let y = forestbunnies (read x)
    print y
    main
