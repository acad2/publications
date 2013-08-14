import Data.Int
import Data.Word
import Data.Array
import Data.Bits

type ControllerState = Int8
type CISCState =  (Word16,Word16,Array Word16 Word16,Array Word8 Word16) --IR, PC, Mem, RF
type Instruction = Word16
type InstructionFields = (Word8,Word8,Word8,Word8) --Type/Op/..., Dest, Src1, Src2

initialState :: CISCState
initialState = (0,0,listArray (0,maxBound) (replicate 65536 0), listArray (0,7) (replicate 8 0))

decodeInstruction :: Instruction -> InstructionFields
decodeInstruction ir = (fromIntegral (shiftR ir 9),fromIntegral ((shiftR ir 6) .&. 7),fromIntegral ((shiftR ir 3) .&. 7),fromIntegral (ir .&. 7))

executeInstruction :: CISCState -> CISCState
executeInstruction x = executeInstruction' (fetchInstruction x)

fetchInstruction :: CISCState -> (CISCState,InstructionFields)
fetchInstruction (_,pc,mem,rf) = ((ir,pc+1,mem,rf),decodeInstruction ir) where ir = mem!pc

fetchAdress :: CISCState -> (CISCState,Word16)
fetchAdress (ir,pc,mem,rf) = ((ir,pc+1,mem,rf),mem!pc)

executeInstruction' :: (CISCState,InstructionFields) -> CISCState
executeInstruction' (x,inf) | ty == 0 = executeRegisterInstruction x inf
                            | ty == 1 = executeMoveInstruction x inf
                            | ty == 2 = executeJumpInstruction x inf
                            | ty == 3 = executeOtherInstruction x inf
                            | otherwise = x
                            where (opc,_,_,_) = inf
                                  ty = shiftR opc 5

executeRegisterInstruction :: CISCState -> InstructionFields -> CISCState
executeRegisterInstruction x inf | op == 0 = exAsr x inf
                                 | op == 1 = exAsl x inf
                                 | op == 2 = arithmetic x inf
                                 | op == 3 = logic x inf
                                 where (opc,_,_,_) = inf
                                       op = (shiftR opc 3) .&. 3;

exAsr :: CISCState -> InstructionFields -> CISCState
exAsr (ir,pc,mem,rf) (opc,dest,src1,_) = (ir,pc,mem,rf') where n = fromIntegral (opc .&. 7)
                                                               rf' = rf//[(dest,shiftR (rf!src1) n)]

exAsl :: CISCState -> InstructionFields -> CISCState
exAsl (ir,pc,mem,rf) (opc,dest,src1,_) = (ir,pc,mem,rf') where n = fromIntegral (opc .&. 7)
                                                               rf' = rf//[(dest,shiftL (rf!src1) n)]

exAdd :: CISCState -> InstructionFields -> CISCState
exAdd (ir,pc,mem,rf) (opc,dest,src1,src2) = (ir,pc,mem,rf') where rf' = rf//[(dest,(rf!src1)+(rf!src2))]

exSub :: CISCState -> InstructionFields -> CISCState
exSub (ir,pc,mem,rf) (opc,dest,src1,src2) = (ir,pc,mem,rf') where rf' = rf//[(dest,(rf!src1)-(rf!src2))]

exInc :: CISCState -> InstructionFields -> CISCState
exInc (ir,pc,mem,rf) (opc,dest,src1,_) = (ir,pc,mem,rf') where rf' = rf//[(dest,(rf!src1)+1)]

exDec :: CISCState -> InstructionFields -> CISCState
exDec (ir,pc,mem,rf) (opc,dest,src1,_) = (ir,pc,mem,rf') where rf' = rf//[(dest,(rf!src1)-1)]

exMul :: CISCState -> InstructionFields -> CISCState
exMul (ir,pc,mem,rf) (opc,dest,src1,src2) = (ir,pc,mem,rf') where rf' = rf//[(dest,(rf!src1)*(rf!src2))]

exDiv :: CISCState -> InstructionFields -> CISCState
exDiv (ir,pc,mem,rf) (opc,dest,src1,src2) = (ir,pc,mem,rf') where rf' = rf//[(dest,div (rf!src1) (rf!src2))]

exRoot :: CISCState -> InstructionFields -> CISCState
exRoot (ir,pc,mem,rf) (opc,dest,src1,_) = (ir,pc,mem,rf') where rf' = rf//[(dest,squareRoot (rf!src1))]

exNeg :: CISCState -> InstructionFields -> CISCState
exNeg (ir,pc,mem,rf) (opc,dest,src1,_) = (ir,pc,mem,rf') where rf' = rf//[(dest,-(rf!src1))]

exAnd :: CISCState -> InstructionFields -> CISCState
exAnd (ir,pc,mem,rf) (opc,dest,src1,src2) = (ir,pc,mem,rf') where rf' = rf//[(dest,(rf!src1) .&. (rf!src2))]

exNand :: CISCState -> InstructionFields -> CISCState
exNand (ir,pc,mem,rf) (opc,dest,src1,src2) = (ir,pc,mem,rf') where rf' = rf//[(dest,complement $ (rf!src1) .&. (rf!src2))]

exOr :: CISCState -> InstructionFields -> CISCState
exOr (ir,pc,mem,rf) (opc,dest,src1,src2) = (ir,pc,mem,rf') where rf' = rf//[(dest,(rf!src1) .|. (rf!src2))]

exNor :: CISCState -> InstructionFields -> CISCState
exNor (ir,pc,mem,rf) (opc,dest,src1,src2) = (ir,pc,mem,rf') where rf' = rf//[(dest,complement $ (rf!src1) .|. (rf!src2))]

exXor :: CISCState -> InstructionFields -> CISCState
exXor (ir,pc,mem,rf) (opc,dest,src1,src2) = (ir,pc,mem,rf') where rf' = rf//[(dest,xor (rf!src1) (rf!src2))]

exXnor :: CISCState -> InstructionFields -> CISCState
exXnor (ir,pc,mem,rf) (opc,dest,src1,src2) = (ir,pc,mem,rf') where rf' = rf//[(dest,complement $ xor (rf!src1) (rf!src2))]

exMask :: CISCState -> InstructionFields -> CISCState
exMask (ir,pc,mem,rf) (opc,dest,src1,src2) = (ir,pc,mem,rf') where rf' = rf//[(dest,(rf!src1) .&. 1)]

exInv :: CISCState -> InstructionFields -> CISCState
exInv (ir,pc,mem,rf) (opc,dest,src1,_) = (ir,pc,mem,rf') where rf' = rf//[(dest,complement $ (rf!src1))]

arithmetic :: CISCState -> InstructionFields -> CISCState
arithmetic x inf = x

logic :: CISCState -> InstructionFields -> CISCState
logic x inf = x

executeMoveInstruction :: CISCState -> InstructionFields -> CISCState
executeMoveInstruction x inf = x

executeJumpInstruction :: CISCState -> InstructionFields -> CISCState
executeJumpInstruction x inf = x

executeOtherInstruction :: CISCState -> InstructionFields -> CISCState
executeOtherInstruction x inf = x
