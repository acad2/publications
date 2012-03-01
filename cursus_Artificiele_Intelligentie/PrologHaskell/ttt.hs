import Data.List

data Bord = Bord Veld Veld Veld Veld Veld Veld Veld Veld Veld
data Veld = E|X|O deriving Eq
data Pos = Pos Int Int

instance Show Pos where
	show (Pos x y) = (show x)++"/"++(show y)
instance Show Veld where
	show E = " "
	show X = "X"
	show O = "O"
instance Show Bord where
	show (Bord a b c d e f g h i) = "\n+---+  "++(show (score (Bord a b c d e f g h i)))++"\n|"++(show a)++(show b)++(show c)++"|\n|"++(show d)++(show e)++(show f)++"|\n|"++(show g)++(show h)++(show i)++"|\n+---+\n"

instance Eq Bord where
	ba == bb = exactEqBoard ba bb || exactEqBoard ba bbr || exactEqBoard ba bbrr || exactEqBoard ba bbrrr || exactEqBoard swba bb || exactEqBoard swba bbr || exactEqBoard swba bbrr || exactEqBoard swba bbrrr
		where	swba = swap ba
			bbr = rotate bb
			bbrr = rotate bbr
			bbrrr = rotate bbrr

exactEqBoard :: Bord -> Bord -> Bool
exactEqBoard (Bord aa ab ac ad ae af ag ah ai) (Bord ba bb bc bd be bf bg bh bi) = [aa,ab,ac,ad,ae,af,ag,ah,ai] == [ba,bb,bc,bd,be,bf,bg,bh,bi]

rotate :: Bord -> Bord
rotate (Bord a b c d e f g h i) = (Bord g d a h e b i f c)

putMark :: Bord -> Veld -> [Bord]
putMark (Bord a b c d e f g h i) mark = nub [(Bord na nb nc nd ne nf ng nh ni)|[na,nb,nc,nd,ne,nf,ng,nh,ni]<-(putMarkArray [a,b,c,d,e,f,g,h,i] [] mark)]

putMarkArray :: [Veld] -> [Veld] -> Veld -> [[Veld]]
putMarkArray [] _ _ = []
putMarkArray (x:xs) a f	| x == E = ((a++(f:xs)):(putMarkArray xs (a++[x]) f))
			| otherwise = (putMarkArray xs (a++[x]) f)

swap :: Bord -> Bord
swap (Bord a b c d e f g h i) = (Bord g h i d e f a b c)

score :: Bord -> Int
score (Bord a b c d e f g h i) = (rowScore [a,b,c] 0 0)+(rowScore [d,e,f] 0 0)+(rowScore [g,h,i] 0 0)+(rowScore [a,d,g] 0 0)+(rowScore [b,e,h] 0 0)+(rowScore [c,f,i] 0 0)+(rowScore [a,e,i] 0 0)+(rowScore [c,e,g] 0 0)

rowScore :: [Veld] -> Int -> Int -> Int
rowScore [] 0 0 = 0
rowScore [] n 0 = 10^(n-1)
rowScore [] 0 n = -10^(n-1)
rowScore (E:xs) nx no = rowScore xs nx no
rowScore (X:xs) nx 0 = rowScore xs (nx+1) 0
rowScore (X:_) _ _ = 0
rowScore (O:xs) 0 no = rowScore xs 0 (no+1)
rowScore (O:_) _ _ = 0

bordToLaTeX :: Bord -> String
bordToLaTeX bord = "\n\\begin{scope}[xshift=,yshift=]\n \\draw[thick] (-3*\\s,-\\s) -- (3*\\s,-\\s);\n \\draw[thick] (-3*\\s,\\s) -- (3*\\s,\\s);\n \\draw[thick] (-\\s,-3*\\s) -- (-\\s,3*\\s);\n \\draw[thick] (\\s,-3*\\s) -- (\\s,3*\\s);\n \\draw (3*\\s,3*\\s) node[anchor=south west,scale=4*\\s]{"++(show (score bord))++"};"++(bordToLaTeXCross bord)++(bordToLaTeXCircle bord)++"\n\\end{scope}"

getPosList :: Bord -> Veld -> [Pos]
getPosList (Bord a b c d e f g h i) mark = (getPosLine [a,b,c] mark (-1) (-1))++(getPosLine [d,e,f] mark 0 (-1))++(getPosLine [g,h,i] mark 1 (-1));

getPosLine :: [Veld] -> Veld -> Int -> Int -> [Pos]
getPosLine [] _ _ _ = []
getPosLine (f:fs) mark y x	| mark == f = (Pos y x : getPosLine fs mark y (x+1))
				| otherwise = getPosLine fs mark y (x+1)

bordToLaTeXCross :: Bord -> String
bordToLaTeXCross b	| length xpos == 0 = ""
			| otherwise = "\n \\foreach\\x/\\y in {"++list++"} {\n  \\draw[thick] (-0.7*\\s+2*\\s*\\x,-0.7*\\s-2*\\s*\\y) -- (0.7*\\s+2*\\s*\\x,0.7*\\s-2*\\s*\\y);\n  \\draw[thick] (0.7*\\s+2*\\s*\\x,-0.7*\\s-2*\\s*\\y) -- (-0.7*\\s+2*\\s*\\x,0.7*\\s-2*\\s*\\y);\n }"
			where	xpos = (getPosList b X)
				sxpos = show xpos;
				list = take ((length sxpos) - 2) (tail sxpos)
bordToLaTeXCircle :: Bord -> String
bordToLaTeXCircle b	| length opos == 0 = ""
			| otherwise = "\n \\foreach\\x/\\y in {"++list++"} {\n  \\draw[thick] (2*\\s*\\x,-2*\\s*\\y) circle (0.7*\\s);\n }"
			where	opos = getPosList b O
				sopos = show opos;
				list = take ((length sopos) - 2) (tail sopos)
