\ProvidesClass{kulpresentation}
\LoadClassWithOptions{beamer}
\institute{KU Leuven}

\mode<presentation>

\RequirePackage[english]{babel}				%internationalization
\RequirePackage{amsfonts}					%set of miscellaneous TeX fonts that augment the standard Computer Modern set
\RequirePackage{amssymb}					%American Mathematical Society package for math symbols
\RequirePackage{tikz}						%inline graphics
\RequirePackage{color,graphicx,xparse,ifthen,epstopdf,colortbl}
\usetikzlibrary{fit,patterns,snakes,calc,decorations,decorations.text,positioning,decorations.pathreplacing,matrix,arrows,automata}

\newcommand{\checkforcomplex}[3]{\ifcsname#1\endcsname #2 \else #3 \fi}

%Colors
\definecolor{blue_kuleuven}{RGB}{17,110,138}			%blue of the university
\setbeamercolor{normal text}{fg=blue_kuleuven}			%text color
\setbeamercolor{frametitle}{fg=blue_kuleuven}			%frame title color
\setbeamercolor{section in toc}{fg=blue_kuleuven}		%toc (section) color
\setbeamercolor{section in toc shaded}{fg=blue_kuleuven}	%toc (shaded section) color
\setbeamercolor{item}{fg=blue_kuleuven}				%item color
\setbeamercolor{subitem}{fg=blue_kuleuven}			%subitem color
\setbeamercolor{subsubitem}{fg=blue_kuleuven}			%subsubitem color
\setbeamercolor{text}{fg=white,bg=blue_kuleuven}		%text block color
\setbeamercolor{block title}{bg=blue_kuleuven,fg=white}		%block title color
\setbeamercolor{block body}{bg=black!20!white,fg=blue_kuleuven}	%block body color


%inner theme
%enumerate list
\setbeamertemplate{enumerate item}[square]		%item symbol
\setbeamertemplate{enumerate subitem}[square]		%item symbol
\setbeamertemplate{sections/subsections in toc}[ball]	%toc symbols
\setbeamertemplate{itemize item}[triangle]		%toc symbols
\setbeamertemplate{item}[triangle]			%toc symbols
\setbeamertemplate{subitem}[triangle]			%toc symbols
\setbeamertemplate{subsubitem}[triangle]		%toc symbols
\setbeamersize{text margin left=0.2cm,text margin right=0.2cm, text margin top=5cm} %text margins

\checkforcomplex{rowcolors}{\rowcolors{1}{}{blue_kuleuven!10}}{}

\usefonttheme[onlymath]{serif}					%math font
\setbeamerfont{frametitle}{size = \bf \large}			%frame title font size
\setbeamerfont{enumerate item}{size=\Large}			%item symbol font size

\setbeamertemplate{frametitle}{
\setbeamertemplate{itemize items}[square]
\vskip 2mm{\thesection~--~\insertframetitle} \hfill {\normalsize \textbf{\insertframenumber/\inserttotalframenumber}}}
\defbeamertemplate{headline}{body}{\begin{tikzpicture}[overlay]\node at (current page.north west) [xshift=1mm,yshift=-8mm] (lnode) {};\node at (current page.north east) [xshift=-1mm,yshift=-8mm] (rnode) {};\draw[thick] (lnode) -- (rnode);\end{tikzpicture}}
\defbeamertemplate{headline}{title_page}{}		
\defbeamertemplate{footline}{body}{\begin{tikzpicture}[overlay]\node [draw,fill=blue_kuleuven,minimum width=1.01\paperwidth,minimum height=.067\paperheight,anchor=south west,xshift=-.3mm,yshift=-.25mm] at (current page.south west) {};\node [anchor= east,inner sep=0,xshift=-.03\paperwidth,yshift=.073\paperheight] at (current page.south east) {\includegraphics[width=.16\textwidth]{kuleuven.pdf}};\node [white,minimum width=.1\paperwidth,minimum height=.01\paperheight,anchor=south west,xshift=3mm] (title) at (current page.south west) {\normalsize \inserttitle~-- \insertauthor};\end{tikzpicture}}
\defbeamertemplate{footline}{title_page}{}	
		
\setbeamertemplate{title page}{
  \begin{tikzpicture}[remember picture,overlay]
  \node [draw,fill=blue_kuleuven,thick,minimum width=1.01\paperwidth,minimum height=.9\paperheight,anchor=south west,xshift=-.3mm,yshift=-.25mm] at (current page.south west) {};
  \node [anchor= west,inner sep=0,xshift=.04\paperwidth,yshift=.89\paperheight] at (current page.south west) {\includegraphics[width=.22\textwidth]{kuleuven.pdf}};
  \node [anchor= center,inner sep=0,xshift=-.07\paperwidth,yshift=.13\paperheight] at (current page.south east) {\includegraphics[width=.05\textwidth]{sedes_wit.png}};
  \node [anchor=south west,inner sep=0,xshift=.08\paperwidth,yshift=.12\paperheight] at (current page.south west) {\includegraphics[height=.6\paperheight]{sleutel.pdf}};	
  \node [white,text width=.7\paperwidth,minimum height=.2\paperheight,anchor=south west,xshift=3.5cm,yshift=3mm] (title) at (current page.west) {\huge\inserttitle};
  \node [white,minimum width=.1\paperwidth,anchor=north west] (subtitle) at (title.south west) {\insertsubtitle};
  \node [blue_kuleuven!20,minimum width=.1\paperwidth,below=of subtitle.west,node distance=2mm,anchor=north west] (author) {\parbox{6 cm}{\insertauthor}};
  \node [white,text width=.45\paperwidth,below=of author.west,anchor=west] (institute) {\insertinstitute};
  \node [white,minimum width=.1\paperwidth,below=of institute.west,anchor=west] {\insertdate};
  \end{tikzpicture}
}

\AtBeginSection[] {\begin{frame}{Outline}\vskip 5mm\hfill{\large\parbox {.95\textwidth}{\tableofcontents[currentsection,hideallsubsections]}}\end{frame}}

% \setitemize{label=\usebeamerfont*{itemize item}%
%   \usebeamercolor[fg]{itemize item}
%   \usebeamertemplate{itemize item}
% }

\mode<all>