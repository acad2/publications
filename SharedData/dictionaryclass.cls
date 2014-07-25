\ProvidesClass{dictionaryclass}
\LoadClass{extbook}
\RequirePackage{makeidx,glossaries,../SharedData/dictionary,xparse,hyperref}
\makeindex
\makeglossaries

\newglossarystyle{dicgls}{%
 \setglossarystyle{treegroup}%
 \renewcommand*{\glossentry}[2]{%
   \glsentryitem{##1}\index{#1|textbf}\entry[##1]{\glstarget{##1}{\glossentryname{##1}}}{\glossentrydesc{##1}}
   %\glsentryitem{##1}\textit{\glstarget{##1}{\glossentryname{##1}}}%
   %:\space \glossentrydesc{##1}\par
   %\entry[\glsentryitem{##1}]{\glstarget{##1}}{\glossentrydesc{##1}}
 }%
 \renewcommand*{\glsgroupheading}[1]{\ifthenelse{\equal{#1}{glssymbols}}{\clearpage\lettergroup{\#}\dictchar{\#}}{\clearpage\lettergroup{\glsgetgrouptitle{##1}}\dictchar{\glsgetgrouptitle{##1} \lowercase{\glsgetgrouptitle{##1}}}}}
 \renewcommand*{\glossarysection}[2][]{}
}
\setglossarystyle{dicgls}

\newcommand{\todef}{}
\DeclareDocumentCommand{\dey}{ O{} m m O{} }{\newglossaryentry{#1}{name={#2},description={\renewcommand{\todef}{\emph{#2}}#3},see={#4}}}
\DeclareDocumentCommand{\rey}{ m }{\textit{\gls{#1}}}

\AtBeginDocument{\maketitle}
\AtEndDocument{\clearpage\lettergroup{?}\dictchar{Index}\printindex}