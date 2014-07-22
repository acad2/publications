\ProvidesClass{dictionaryclass}
\LoadClass{extbook}
\RequirePackage{glossaries,../SharedData/dictionary,hyperref}
\makeglossaries

\newglossarystyle{dicgls}{%
 \setglossarystyle{treegroup}%
 \renewcommand*{\glossentry}[2]{%
   \glsentryitem{##1}\entry[##1]{\glstarget{##1}{\glossentryname{##1}}}{\glossentrydesc{##1}}
   %\glsentryitem{##1}\textit{\glstarget{##1}{\glossentryname{##1}}}%
   %:\space \glossentrydesc{##1}\par
   %\entry[\glsentryitem{##1}]{\glstarget{##1}}{\glossentrydesc{##1}}
 }%
 \renewcommand*{\glsgroupheading}[1]{\clearpage\lettergroup{\glsgetgrouptitle{##1}}\dictchar{\glsgetgrouptitle{##1}}}
 \renewcommand*{\glossarysection}[2][]{}
}
\setglossarystyle{dicgls}

\newcommand{\defentry}[3][]{\newglossaryentry{#1}{name={#2},description={#3}}}

\AtBeginDocument{\maketitle}