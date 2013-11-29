import Text.ParserCombinators.Parsec

data OP = ASR | ASL | ADD | SUB | INC | DEC | MUL | DIV | ROOT | NEG | AND | NAND | OR | NOR | XOR | XNOR | MASK | INV | LOAD | STOR | COPY | JMP | CJMP | JSR | RTS | NOP | CLR | CLRS | SETS | GT | GE | LT | LE | EQ | NE deriving (Show,Read,Enum)
data Opn = R Int | O Int | D Int | I Int | RI Int | RIR Int Int | AR Int Int deriving Show
data Cmd = Cmd OP [Opn] deriving Show

parseCmd :: CharParser st Opn
parseCmd = do
  x <- parseOpn
  newline
  return x

parseOpn :: CharParser st Opn
parseOpn = parseR <|> parseO <|> parseD <|> parseI <|> parseRI <|> parseRIR <|> parseAR

parseR :: CharParser st Opn
parseR = do
  char 'R'
  r <- digit
  return (R $ read [r])
  
parseO :: CharParser st Opn
parseO = do
  char '#'
  rs <- many1 digit
  return (O $ read rs)

parseD :: CharParser st Opn
parseD = do
  rs <- many1 digit
  return (D $ read rs)

parseI :: CharParser st Opn
parseI = do
  char '('
  rs <- many1 digit
  char ')'
  return (O $ read rs)

parseRI :: CharParser st Opn
parseRI = do
  string "(R"
  r <- digit
  char ')'
  return (RI $ read [r])

parseRIR :: CharParser st Opn
parseRIR = do
  string "(R"
  r <- digit
  string ")+R"
  s <- digit
  return (RIR (read [r]) (read [s]))

parseAR :: CharParser st Opn
parseAR = do
  rs <- many1 digit
  string "+(R"
  r <- digit
  char ')'
  return (AR (read rs) (read [r]))

main = do
  a <- getLine
  putStrLn $ show $ parse parseCmd "" $ a++("\n")
  main
