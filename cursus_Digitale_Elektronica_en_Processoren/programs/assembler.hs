import Text.ParserCombinatorics.Parsec

data OP = ASR | ASL | ADD | SUB | INC | DEC | MUL | DIV | ROOT | NEG | AND | NAND | OR | NOR | XOR | XNOR | MASK | INV | LOAD | STOR | COPY | JMP | CJMP | JSR | RTS | NOP | CLR | CLRS | SETS | GT | GE | LT | LE | EQ | NE deriving (Show,Read,Enum)
data Opn = R Int | O Int | D Int | I Int | RI Int Int | RR Int Int | RX Int Int
data Cmd = Cmd OP [Opn]
