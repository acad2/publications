\ProvidesClass{preziposters}
\LoadClassWithOptions{article}

\RequirePackage[a0paper,landscape,margin=1cm,centering]{geometry}
\RequirePackage{color,amsfonts,tikz,amssymb,graphicx,enumitem,xparse,ifthen,epstopdf,multicol,tablists,catchfile,varwidth}
\usetikzlibrary{fit,patterns,snakes,calc,decorations,decorations.text,positioning,decorations.pathreplacing,matrix,arrows,automata}
\setitemize{noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt}

\pgfdeclarelayer{background}
\pgfdeclarelayer{classes}
\pgfsetlayers{background,classes,main}

\newcounter{postersTmpA}
\newcounter{postersTmpB}

\DeclareDocumentCommand{\defgroup}{ O{5mm} O{0mm} O{0mm} O{} m m m m m}{\begin{scope}[xshift=#2,yshift=#3]\filldraw[#8!40!backg,draw=black,very thick,rounded corners] (0.5*#1,0.5*#1) rectangle ++(#5-#1,#6-#1);\draw (0.5*#1,#6-0.5*#1) node[anchor=north west]{\Huge{\bf #7}};\coordinate (#9) at (0.5*#1,#6-0.5*#1);\coordinate (#9-LT) at (0.5*#1,#6-0.5*#1);\coordinate (#9-RT) at (#5-0.5*#1,#6-0.5*#1);\coordinate (#9-LB) at (0.5*#1,0.5*#1);\coordinate (#9-RB) at (#5-0.5*#1,0.5*#1);\coordinate (ROW-#9-B) at (0,0.5*#1);\coordinate (ROW-#9-T) at (0,#6-0.5*#1);\coordinate (COL-#9-L) at (0.5*#1,0);\coordinate (COL-#9-R) at (#5-0.5*#1,0);\end{scope}\begin{scope}[shift={(#9-RB)}]\node[anchor=south east] (TURLOG) {\resizebox{!}{4 cm}{#4}};\end{scope}}
\DeclareDocumentCommand{\grpholow}{ O{0.5} O{2.00} O{1.00} m m m}{\draw [decorate,line width=3pt] ($(COL-#5)+(-0.5*#1,-#1)$) -- ($(COL-#4)+(0.5*#1,-#1)$);\draw ($0.5*(COL-#4)+0.5*(COL-#5)+(0,-#2)$) node[scale=#3] {\Huge{\bf #6}};}
\DeclareDocumentCommand{\grphoupp}{ O{0.5} O{2.00} O{1.00} m m m}{\draw [decorate,line width=3pt] ($(COL-#4)+(-0.5*#1,#1)$) -- ($(COL-#5)+(0.5*#1,#1)$);\draw ($0.5*(COL-#4)+0.5*(COL-#5)+(0,#2)$) node[scale=#3] {\Huge{\bf #6}};}
\DeclareDocumentCommand{\grpvelef}{ O{0.5} O{2.00} O{1.00} m m m}{\draw [decorate,line width=3pt] ($(ROW-#5)+(-#1,0.5*#1)$) -- ($(ROW-#4)+(-#1,-0.5*#1)$);\draw ($0.5*(ROW-#4)+0.5*(ROW-#5)+(-#2,0)$) node[scale=#3,rotate=-90] {\Huge{\bf #6}};}
\DeclareDocumentCommand{\grpverig}{ O{0.5} O{2.00} O{1.00} m m m}{\draw [decorate,line width=3pt] ($(ROW-#4)+(#1,0.5*#1)$) -- ($(ROW-#5)+(#1,-0.5*#1)$);\draw ($0.5*(ROW-#4)+0.5*(ROW-#5)+(#2,0)$) node[scale=#3,rotate=-90] {\Huge{\bf #6}};}
\DeclareDocumentCommand{\computmul}{ O{LABEL} O{1.00} O{2.00} m m }{\begin{scope}[scale=#3]\begin{scope}\clip[rounded corners=2 mm] (-0.5,-0.5) rectangle (0.5,0.5);\setcounter{postersTmpA}{0}\foreach \c in {#5} {\addtocounter{postersTmpA}{1}}\setcounter{postersTmpB}{0}\foreach \c in {#5} {\fill[\c!60] (0,0) -- (-\arabic{postersTmpB}*360.0/\arabic{postersTmpA}-135:1) arc (-\arabic{postersTmpB}*360.0/\arabic{postersTmpA}-135:-\arabic{postersTmpB}*360.0/\arabic{postersTmpA}-360.0/\arabic{postersTmpA}-135:1) -- cycle;\addtocounter{postersTmpB}{1}\coordinate (#1-S\arabic{postersTmpB}) at (-\arabic{postersTmpB}*360.0/\arabic{postersTmpA}+180.0/\arabic{postersTmpA}-135:0.25);}\setcounter{postersTmpB}{0}\foreach \c in {#5} {\draw[gray,very thick] (-\arabic{postersTmpB}*360.0/\arabic{postersTmpA}-135:1) -- (0,0);\addtocounter{postersTmpB}{1}}\node[scale=#2] (#1-L) at (0,0) {#4};\end{scope}\draw[rounded corners=2 mm,gray,very thick] (-0.5,-0.5) rectangle (0.5,0.5);\end{scope}}
\DeclareDocumentCommand{\titleminibox}{ O{(0,0)} O{LABEL} O{0} O{0} O{10cm} m m m }{\begin{scope}[shift={#1}]\node[anchor=north] (CCD#2) at (#3,-#4) {\begin{varwidth}{#5}\textbf{#6}: #8\end{varwidth}};\node[anchor=north,anchor=south] (CCT#2) at (CCD#2.north) [scale=2]{#7};\draw(CCT#2.south west) -- (CCT#2.south east);\end{scope}\begin{pgfonlayer}{classes}\node[fit=(CCT#2) (CCD#2),draw=black,rectangle,dotted,rounded corners,fill=white] (CC#2) {};\end{pgfonlayer}}
\DeclareDocumentCommand{\groupbox}{ O{3mm} O{white,semitransparent} m m }{\node[fit=#3,inner sep=#1] (TMP) {};\begin{pgfonlayer}{classes}\node (TMP-TITLE) at (TMP.north) {\bf #4};\end{pgfonlayer}\begin{pgfonlayer}{background}\filldraw[rounded corners,fill=#2] (TMP-TITLE.north west) -- (TMP-TITLE.west) -- (TMP.north west) -- (TMP.south west) -- (TMP.south east) -- (TMP.north east) -- (TMP-TITLE.east) -- (TMP-TITLE.north east) -- cycle;\end{pgfonlayer}}
\DeclareDocumentCommand{\defgroupcols}{ m m m }{\foreach \n/\x in {#2} {\coordinate (COL-\n) at ($(#1-LB)+(\x,0)$);}\foreach \n/\x in {#3} {\coordinate (COL-\n) at ($(#1-RB)-(\x,0)$);}}
\DeclareDocumentCommand{\expandgroupcols}{ m m }{\foreach \g in {#1} {\foreach\c in {#2} {\coordinate (\g-\c-LB) at (\g-LB -| COL-\c);\coordinate (\g-\c-LT) at (\g-LT -| COL-\c);\coordinate (\g-\c) at (\g-\c-LT);}}}
\DeclareDocumentCommand{\colorlegend}{ O{LABEL} O {2mm} O {1mm} m }{\coordinate (TMP-R) at (0,0);\coordinate (TMP-C) at (#1,0);\foreach \t/\c/\n in {#4} {\node[circle,fill=\c!60,minimum width=#2,minimum height=#2] (#1-O-\n) at (TMP-R) {};\node[anchor=west] (#1-\n) at (#1-O-\n.east) {\t};\coordinate (TMP-R) at ($(TMP-R)+(0,-2*#2-#3)$);}}
