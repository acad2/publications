type Ins ins reg = (reg,ins,[reg])
type InsCol ins reg = [Ins ins reg]

data Comp = eq | st | lt | lte | ste
data BoolOp = and | or | not
data RegVal reg val = Reg reg | Val val
data Condition = Cond BoolOp Condition Condition | Cond 
