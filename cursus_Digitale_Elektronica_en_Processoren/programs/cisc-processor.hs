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

exAsr :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exAsr rf (opc,dest,src1,_) = rf//[(dest,shiftR (rf!src1) n)] where n = fromIntegral (opc .&. 7)

exAsl :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exAsl rf (opc,dest,src1,_) = rf//[(dest,shiftL (rf!src1) n)] where n = fromIntegral (opc .&. 7)

exAdd :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exAdd rf (opc,dest,src1,src2) = rf//[(dest,(rf!src1)+(rf!src2))]

exSub :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exSub rf (opc,dest,src1,src2) = rf//[(dest,(rf!src1)-(rf!src2))]

exInc :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exInc rf (opc,dest,src1,_) = rf//[(dest,(rf!src1)+1)]

exDec :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exDec rf (opc,dest,src1,_) = rf//[(dest,(rf!src1)-1)]

exMul :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exMul rf (opc,dest,src1,src2) = rf//[(dest,(rf!src1)*(rf!src2))]

exDiv :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exDiv rf (opc,dest,src1,src2) = rf//[(dest,div (rf!src1) (rf!src2))]

exRoot :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exRoot rf (opc,dest,src1,_) = rf//[(dest,squareRoot (rf!src1))]

exNeg :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exNeg rf (opc,dest,src1,_) = rf//[(dest,-(rf!src1))]

exAnd :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exAnd rf (opc,dest,src1,src2) = rf//[(dest,(rf!src1) .&. (rf!src2))]

exNand :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exNand rf (opc,dest,src1,src2) = rf//[(dest,complement $ (rf!src1) .&. (rf!src2))]

exOr :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exOr rf (opc,dest,src1,src2) = rf//[(dest,(rf!src1) .|. (rf!src2))]

exNor :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exNor rf (opc,dest,src1,src2) = rf//[(dest,complement $ (rf!src1) .|. (rf!src2))]

exXor :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exXor rf (opc,dest,src1,src2) = rf//[(dest,xor (rf!src1) (rf!src2))]

exXnor :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exXnor rf (opc,dest,src1,src2) = rf//[(dest,complement $ xor (rf!src1) (rf!src2))]

exMask :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exMask rf (opc,dest,src1,src2) = rf//[(dest,(rf!src1) .&. 1)]

exInv :: Array Word8 Word16 -> InstructionFields -> Array Word8 Word16
exInv rf (opc,dest,src1,_) = rf//[(dest,complement $ (rf!src1))]

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
