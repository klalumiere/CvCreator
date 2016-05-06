% resume.cls
%
%    Copyright 2005 Daniel Burrows
%
% You may use, modify, and redistribute this file in any way you please, so
% long as this copyright notice is maintained.


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume2}

\LoadClassWithOptions{article}

% No page numbers by default.
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}


\RequirePackage{beamerarticle}
\RequirePackage{multicol}
\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{url}
\RequirePackage{tabularx}
\RequirePackage{pgf}
%\RequirePackage{pgfshade}
\RequirePackage{xxcolor}

\RequirePackage[english,french]{babel}
\RequirePackage{inputenc}
%\RequirePackage{eurosym}
\RequirePackage{graphicx}

\RequirePackage{times}
\RequirePackage[T1]{fontenc}

\RequirePackage[tmargin=1in,bmargin=1in]{geometry}
\definecolor{rulestartcolor}{rgb}{0,0,0}
\definecolor{ruleendcolor}{rgb}{0.4,0.4,0.4}
\newlength{\headerbuffer}
\setlength{\headerbuffer}{2pt}
\newlength{\secskip}
\setlength{\secskip}{6pt}

\newlength{\@headerscratch}

% Usage: \@setupshading{width}{height}{start}{end}
\newcommand{\@setupshading}[4]{%
  \pgfdeclarehorizontalshading{@ruleshading}{#2}{%
    color(0pt)=(#3); color(#1)=(#4)%
  }
}

\newcommand{\pgfrule}[4]{%
  \begin{pgfpicture}{0pt}{0pt}{#1}{#2}%
    \pgfdeclarehorizontalshading{@ruleshading}{#2}{%
      color(0pt)=(#3); color(#1)=(#4)%
    }
    \pgfputat{\pgfxy(0,0)}{\pgfbox[left,bottom]{\pgfuseshading{@ruleshading}}}
  \end{pgfpicture}%
}

\newcommand{\lrule}[2]{\pgfrule{#1}{#2}{rulestartcolor}{ruleendcolor}}
\newcommand{\rrule}[2]{\pgfrule{#1}{#2}{ruleendcolor}{rulestartcolor}}

\newcommand{\@authorname}{}
\newcommand{\@email}{}
\newcommand{\@streetaddress}{}
\newcommand{\@citystatezip}{}
\newcommand{\@phone}{}
\newcommand{\@phonework}{}
\newcommand{\@webpage}{}
\newcommand{\@pic}{}
\newcommand{\@langue}{}


\renewcommand{\author}[1]{\renewcommand{\@authorname}{#1}}
\newcommand{\email}[1]{\renewcommand{\@email}{#1}}
\newcommand{\streetaddress}[1]{\renewcommand{\@streetaddress}{#1}}
\newcommand{\citystatezip}[1]{\renewcommand{\@citystatezip}{#1}}
\newcommand{\phone}[1]{\renewcommand{\@phone}{#1}}
\newcommand{\phonework}[1]{\renewcommand{\@phonework}{#1}}
\newcommand{\webpage}[1]{\urldef{\@webpage}{\url}{#1}}
\newcommand{\pic}[1]{\renewcommand{\@pic}{#1}}
\newcommand{\langue}[1]{\renewcommand{\@langue}{#1}}


\renewcommand{\maketitle}{{%
  \setlength{\@headerscratch}{\linewidth*2/3}%
%  \noindent \lrule{\@headerscratch}{1.5pt}%
  \vspace{\headerbuffer}%
  \ifthenelse{\equal{\@email}{}}{%
    \par\nointerlineskip\noindent\makebox[\linewidth]{\textbf{\Large{\@authorname}}}%
  } {%
    \par\nointerlineskip\noindent\makebox[\linewidth]{\textbf{\Large{\@authorname}}}%
  }%
  \par\nointerlineskip\noindent%
  \hspace{\linewidth}%
  \hspace{-\@headerscratch}%
%  \rrule{\@headerscratch}{1.5pt}%
  \par\nointerlineskip\noindent%
  % Typeset webpage/phone in columns if both are specified, or
  % just on the LHS if only one is.
	\ifthenelse{\equal{\@email}{}}{}{\begin{center}\@email\end{center}}
	\begin{tabularx}{\linewidth}{Xr}
		\@streetaddress & \ifthenelse{\equal{\@phone}{}}{}{\@phone (maison)} \\
		\@citystatezip & \ifthenelse{\equal{\@phonework}{}}{}{\@phonework (bureau)}
	\end{tabularx}
  \begin{center}
	  	\ifthenelse{\equal{\@langue}{}}{}{Communication orale et écrite:~\@langue}
	\end{center}
	\ifthenelse{\equal{\@webpage}{}}{}{
	\begin{minipage}{.45\textwidth}
		\begin{flushright}
			\begin{tabular}{r}
					Page internet:~\@webpage
			\end{tabular}
		\end{flushright}
	\end{minipage}
	}
}}

\renewcommand{\section}[1]{%
 \goodbreak\vspace{\secskip}\par\nointerlineskip\noindent\textbf{\textsc{\large\makebox[\linewidth][l]{#1}}}\vspace{\headerbuffer}\par\nointerlineskip\noindent%
	\lrule{\linewidth}{0.4pt}\vspace{-12pt}
	\lrule{\linewidth}{0.4pt}%
  \vspace{\headerbuffer}\par\nointerlineskip\goodbreak\vspace{\secskip}}

\renewcommand{\subsection}[1]{%
  \goodbreak\vspace{\secskip}\par\nointerlineskip\vspace{-1em}\textbf{\flushleft{#1} :}\par%
}

% General catch-all for either educational or job affiliation.
%
%  Usage:
% \affiliation[title]{institution}{years}
\newcommand{\affiliation}[3]{%
\ifthenelse{\equal{#1}{}}{}{%
    \textbf{#1}}%
    \hfill #3\\
  #2
}%

\newenvironment{diploma}[3]{
\noindent
\affiliation{#1}{#2}{#3}
}
{
\par\noindent%
\ignorespacesafterend
}

\newenvironment{job}[3]{
\noindent
\affiliation{#1}{#2}{#3}
\vspace{\headerbuffer}\par\nointerlineskip\noindent
\lrule{\linewidth}{0.4pt}%
\vspace{2pt}
\par\noindent
}
{
\vspace{6pt}
\par\noindent%
\ignorespacesafterend
}

\newcommand{\award}[3]{
\noindent
\begin{tabularx}{\linewidth}{Xr}%
	\textbf{#1} & #3 \ifthenelse{\equal{#2}{}}{}{\\
	#2 &}%
\end{tabularx} \\%
}

\newenvironment{involvement}[3]{
\noindent
\begin{tabularx}{\linewidth}{Xr}%
  	\textbf{#1} & #3 \\
	#2 &
\end{tabularx} \\%
}
{
\vspace{6pt}
\par\noindent%
\ignorespacesafterend
}
\pagestyle{fancy}