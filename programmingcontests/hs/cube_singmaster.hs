module Main where
import Utils (mapIth,rotateR)

type RubikSide a = [[a]]
type RubikCube a = [RubikSide a]
data RubikFace = B | D | F | L | R | U deriving (Enum,Bounded,Show)
data ShiftPart = Col RubikFace Int | Row RubikFace Int

rubikFaces :: [RubikFace]
rubikFaces = [minBound ..]

toShiftParts :: RubikFace -> (Bool,[ShiftPart])
toShiftParts B = (False,[Row B 1,Row R 1,Row F 1,Row L 1])
toShiftParts D = (False,[Row F 3,Row R 3,Row B 3,Row L 3])
toShiftParts F = (False,[Row B 1,Row R 1,Row F 1,Row L 1])
toShiftParts L = (False,[Row B 1,Row R 1,Row F 1,Row L 1])
toShiftParts R = (False,[Col B 1,Col R 1,Col F 1,Col L 1])
toShiftParts U = (False,[Row B 1,Row R 1,Row F 1,Row L 1])

face :: RubikFace -> RubikCube a -> RubikSide a
face f c = c!!(fromEnum f)

initCube :: [[[RubikFace]]]
initCube = map (replicate 3 . replicate 3) rubikFaces

singerMove :: RubikFace -> RubikCube a -> RubikCube a
singerMove f r = mapIth (fromEnum f) rotateR r
