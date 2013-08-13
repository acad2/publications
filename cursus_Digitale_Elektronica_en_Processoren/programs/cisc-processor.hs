import Data.Int
import Data.Array
import Data.Bits

type CISCState =  (Int16,Int16,Array Int16 Int16,Array Int8 Int16) --IR, PC, Mem, RF

initialState :: CISCState
initialState = (0,0,replicate 0 65536, replicate 0 8)

executeInstruction :: CISCState -> CISCState
executeInstruction (_,pc,mem,rf) = executeInstruction' (ir,pc+1,mem,rf) where ir = mem!pc

executeInstruction' :: CISCState -> Int16 -> Int16 -> CISCState
executeInstruction' (ir,pc,mem,rf) | ty == 0 = executeRegisterInstruction (ir,pc,mem,rf) ir
                                   | ty == 1 = executeMoveInstruction (ir,pc,mem,rf) ir
                                   | ty == 2 = executeJumpInstruction (ir,pc,mem,rf) ir
                                   | ty == 3 = executeOtherInstruction (ir,pc,mem,rf) ir
                                   | otherwise = (ir,pc,mem,rf)
                                   where ty = shift ir -14

executeRegisterInstruction' :: CISCState -> CISCState

fetchAdress :: CISCState -> (CISCState,Int16)
fetchAdress (ir,pc,mem,rf) = ((ir,pc+1,mem,rf),mem!pc)
