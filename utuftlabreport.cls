% version 1.0 2018/09/17 Initial version. Based on the thesis template

% ------------------------------
% How to use? Store the file in
% 1) Windows XP C:\Documents and Settings\<user name>\texmf\tex\latex\local\
% 2) Windows Vista/7 C:\Users\<user name>\texmf\tex\latex\local\
% 3) Linux ~/texmf/tex/latex/local/
% 4) Mac OS X /Users/<user name>/Library/texmf/tex/latex/local/
% 5) Sharelatex: just copy this to the project folder
% 6) or in the same directory as the document
% ------------------------------

\NeedsTeXFormat{LaTeX2e}[2007/01/01]
\ProvidesClass{utuftlabreport}[2018/09/17 UTU FT dept lab report]

\RequirePackage{kvoptions}

\newcommand{\n@tivelang}{finnish}

%% Custom package options
\DeclareStringOption[finnish]{language}
\DeclareStringOption[true]{hidechapters}
\DeclareStringOption[false]{includereferences}

%% Process given options
\ProcessKeyvalOptions*

%% Fallback
%\DeclareOption*{}
%  \ClassWarning{myclass}{Unknown option '\CurrentOption'}
%\ProcessOptions\relax

%% Load base
\LoadClass[a4paper,12pt]{report}

\RequirePackage{ifthen}

%% Some language macros for choosing between content
\newcommand{\langchoose}[3]{\ifthenelse{\equal{#1}{\n@tivelang}}{#2}{#3}}
\newcommand{\langfin}[2]{\ifthenelse{\equal{\utuftlabreport@language}{\n@tivelang}}{#1}{#2}}
\newif\iffin
\langfin{\fintrue}{\finfalse}

\RequirePackage{ifxetex}

%% Set up encoding/font/hyphenation stuff
\ifxetex
  \RequirePackage{fontspec}
  \RequirePackage{polyglossia}
  \setmainlanguage{\utuftlabreport@language}
\else
% JH: modified latin to UTF-8 encoding cues to make Scandinavian characters works
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
% load babel-package for automatic hyphenation
  \iffin
  \RequirePackage[english, \utuftlabreport@language]{babel}
  \else
  \RequirePackage[\utuftlabreport@language]{babel}
  \fi
  \RequirePackage{lmodern}
\fi

\RequirePackage{csquotes}

%% Macro for hiding the chapter texts
\ifthenelse{\equal{\utuftlabreport@hidechapters}{true}}{
  \renewcommand{\@chapapp}{\relax}
  \renewcommand{\@makechapterhead}[1]{%
    \vspace*{50\p@}%
    {\parindent \z@ \raggedright \normalfont
      \ifnum \c@secnumdepth >\m@ne
          \huge\bfseries \@chapapp\space \thechapter\space\space
      \fi
      \interlinepenalty\@M
      \Huge \bfseries #1\par\nobreak
      \vskip 40\p@
    }}
}
{}

%% load ams-packages for maths
\RequirePackage{amssymb,amsthm,amsmath}

%% load graphicx package
%   - automagically select proper parameters depending on whether
%     we're running pdflatex or latex
%   - specify \includegraphics{file} without the file extension
%     (.eps /.pdf (/ .png / .jpeg / ...)), tex should select the proper file
%
\RequirePackage{ifpdf}
\RequirePackage{graphicx}

%% JM: this note refers to some pre-historic latex distributions, probably
%% safe to disregard
%% 
%% !!! NOTE: if you have ancient LaTeX distribution then you might need to
%% use the following instead
%% \newif\ifpdf
%% \ifx\pdfoutput\undefined
%%   \pdffalse
%% \else
%%   \pdfoutput=1
%%   \pdftrue
%% \fi
%% % if graphicx complains about option clash remove the [pdftex] option
%% \ifpdf
%%   \RequirePackage[pdftex]{graphicx}
%% \else
%%   \RequirePackage[dvips]{graphicx}
%% \fi

\RequirePackage[style=ieee]{biblatex}

%% Define new title texts for the bibliography
\langfin
{\newcommand{\refs}{Lähdeluettelo}}
{\newcommand{\refs}{References}}

%% Modify the \printbibliography command
\defbibheading{bibliography}{
%\eofpages
% label here if we don't include references
\ifthenelse{\equal{\utuftlabreport@includereferences}{true}}{}{\label{endofpages}}
\chapter*{\refs}
\addcontentsline{toc}{chapter}{\refs}}

\let\oldprintbibliography\printbibliography
\renewcommand{\printbibliography}{
\oldprintbibliography
% label here if we also include references
\ifthenelse{\equal{\utuftlabreport@includereferences}{true}}{\label{endofpages}}{}
}

%% load sverb package
%   - enhanced handling of verbatim stuff; listing environment
\RequirePackage{sverb}

%% load listings package
%   - handle inclusion of source code
\RequirePackage{listings}

%% load fancyheaders package
%   - the actual headers and footers are set later
\RequirePackage{fancyhdr}

%% these are used as global variables on the magic pages
%% feel free to modify if/when the department changes again
\newcommand\groupmembers[1]{\def\gr@up{#1}}
\newcommand\pubyear[1]{\renewcommand\ye@r{#1}}
\newcommand\pubmonth[1]{\renewcommand\m@nth{#1}}
\newcommand\pubcourse[1]{\newcommand\c@urse{#1}}
\newcommand\publab[2]{\newcommand\p@blab{#1}\newcommand\p@blaben{#2}}
\newcommand\pubtype[2]{\newcommand\p@btype{#1}\newcommand\p@btypeen{#2}}
\newcommand{\laitos}{Tulevaisuuden teknologioiden laitos}
\newcommand{\yliopisto}{Turun yliopisto}
\newcommand{\department}{Department of Future Technologies}
\newcommand{\university}{University of Turku}
\newcommand{\@pp}{\langfin{sivua}{pages}}
\newcommand{\@app}{\langfin{liites.}{app. p.}}

% switch-case used to select the report type
\newboolean{default}
\newcommand{\case}{}
\newcommand{\default}{}
\newenvironment{switch}[1]{%
    \setboolean{default}{true}
    \renewcommand{\case}[2]{\ifthenelse{\equal{#1}{##1}}{%
        \setboolean{default}{false}##2}{}}%
    \renewcommand{\default}[1]{\ifthenelse{\boolean{default}}{##1}{}}
}{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% setup document appearance
%

% change default font to times-roman
\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{ptm}
\renewcommand{\ttdefault}{pcr}

% fix page size
%
%  - page width: 
%     1inch             +
%      \hoffset         +
%      \oddsidemargin   +
%      \textwidth       +
%      \marginsep       +
%      \marginparwidth
%
%  - page height: 
%     1inch             +
%      \voffset         +
%      \topmargin       +
%      \headheight      +
%      \headsep         +
%      \textheight      +
%      \footnotesep     +
%      \footheigth 
%
%  - 1 pt == 1/72 inch == 0.35 mm
%
% page width... left margin 4cm, right 2cm
%
\setlength{\hoffset}{0mm}
\setlength{\marginparsep}{0mm}
\setlength{\marginparwidth}{0mm}
\setlength{\textwidth}{\paperwidth}
\addtolength\textwidth{-60 mm}
\setlength{\oddsidemargin}{-1 in}
\addtolength\oddsidemargin{40 mm}
%
% page height... textheight starts at ~4cm from top, 
% i.e. 1 in + 12 pt + 24 pt = 1.5 in 
%
\setlength{\voffset}{0 mm}
\setlength{\topmargin}{0 mm}
\setlength{\headheight}{14.5 pt}
\setlength{\headsep}{24 pt}
\setlength{\textheight}{230mm}
\setlength{\footnotesep}{12 pt}

 
% setup linespacings to suit to the (stupid) requirement of double spacing
%
% - fake 1.5 linespacing
%    \renewcommand{\baselinestretch}{1.241}
%
% - fake 2 linespacing
%
\renewcommand{\baselinestretch}{1.655}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% provide the entry environment
%

\newenvironment{entry}[1]
{\begin{list}{}{%
      \renewcommand{\makelabel}[1]{\textrm{##1:}\hfil}%
      \settowidth{\labelwidth}{\textrm{#1:}}%
      \setlength{\leftmargin}{\labelwidth}%
      \addtolength{\leftmargin}{\labelsep}}}
{\end{list}}


%% appendix title, abstract environments
\langfin{
  \newcommand{\appname}{Liitteet}
  \renewenvironment{abstract}{\@bstracth{finnish}}{\@bstractt{finnish}{\k@ywords}}
}{
  \newcommand{\appname}{Appendices}
  \renewenvironment{abstract}{\@bstracth{english}}{\@bstractt{english}{\k@ywords}}
}

%% used for listing the group members
\RequirePackage{pgffor}

    
%% used to detect the number of pages
\RequirePackage[page]{totalcount}

%% used to detect the empty \totalpages on the first latex run
\newcommand*{\IsInteger}[3]{%
    \IfStrEq{#1}{ }{%
        %#3% is a blank string
    }{%
        \IfInteger{#1}{#2}{#3}%
    }%
}%

\RequirePackage{xstring}

%% title page, reuses the standard \maketitle
\renewcommand*{\maketitle}{%
\clearpage 
\thispagestyle{empty}
\includegraphics[width=60mm]{kuvat/turun-yliopisto.pdf}

\vspace*{\stretch{1}}
\vspace{3mm}
\noindent 
\rule{\linewidth}{1 mm}
\renewcommand{\baselinestretch}{1.05}\normalsize
\begin{flushright}
\Huge{\c@urse}\\
\huge{\@title}
\end{flushright}
\rule{\linewidth}{1 mm}
\vspace*{\stretch{4}}
\\
\parbox{78mm}{\ }
\parbox[top]{72mm}{
\renewcommand{\baselinestretch}{1}\normalsize
\langfin{Ryhmä}{Group}:\\
\foreach \x in \gr@up {       
\hspace*{2ex} \x\\
}\\
\@title\\
\today\\
\IsInteger{\totalpages}{
\ifnum \totalpages > 0
  \pageref{endofpages} \@pp, \totalpages\ \@app \\
\else
  \pageref{endofpages} \@pp \\
\fi
}
{\langfin{aja LaTeX uudestaan}{please rerun LaTeX} \\
}\\
\langfin{\yliopisto}{\university}\\
\langfin{\laitos}{\department}\\
\langfin{\p@blab}{\p@blaben}\\
\c@urse
}
%\vspace*{\stretch{1}}\\
\renewcommand{\baselinestretch}{1.655}\normalsize
\clearpage

\pagestyle{empty}
\fancypagestyle{plain}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0 pt}
}

% roman numbering for table of contents etc.
\pagenumbering{roman}

%\setcounter{page}{0}
\tableofcontents
\clearpage
%\setcounter{page}{0}
%\listoffigures 
%\clearpage
%\setcounter{page}{0}
%\listoftables

%\setcounter{secnumdepth}{-1}
%\input{your acronym chapter's file name}
%\setcounter{secnumdepth}{2}

% setup page numbering, page counter, etc.
\startpages
}
  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% define \figcaption and \tblcaption for use with non-floating figures and 
% tables
%

\makeatletter
  \newcommand\figcaption{\def\@captype{figure}\caption}
  \newcommand\tblcaption{\def\@captype{table}\caption}
  \newcommand{\thecourse}[1]{\c@urse}
\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% define \startpages
%

\newcommand{\startpages}{%
        \clearpage
        \pagenumbering{arabic}
        \setcounter{page}{1}
        \renewcommand{\baselinestretch}{1.655}

        \pagestyle{fancy}
        \renewcommand{\chaptermark}[1]{
          \markboth{
            \MakeUppercase{\chaptername\ \thechapter.\ ##1}}
          {}
        }
        \lhead{\leftmark}

\chead{\thecourse}
        \rhead{\thepage}
        \fancyfoot{}
  \setcounter{totalcount@page}{-1000}
}       



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% define \appendices
%
\newcommand{\appendices}{%
  \newpage
  \appendix
  \addtocontents{toc}{\protect\contentsline{chapter}{\appname}{}\relax}
  \renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{\appendixname\ \thechapter.\ ##1}}{}}
  \lhead{\leftmark}
  \chead{}
  \rhead{\thechapter-\arabic{page}}
  \fancyfoot{}
  \setcounter{page}{0}
  \renewcommand\thepage{\thechapter-\arabic{page}}
  \setcounter{totalcount@page}{-1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% define \appchapter
%
\newcommand{\appchapter}[1]{%
        \addtocounter{totalcount@page}{\value{page}}
        \clearpage
        \setcounter{page}{1}
        \chapter{#1}
}

%% automatically handle the appendix magic
%\AtEndDocument{\addtocounter{totalcount@page}{-2}}

\lstnewenvironment{javacode}
  { \lstset{language=[10]Java,literate=
  {ä}{{\"a}}1 {ö}{{\"o}}1
  {Ä}{{\"A}}1 {Ö}{{\"O}}1 } }
  {}
\lstnewenvironment{jscode}
  { \lstset{language=Javascript} }
  {}
\lstnewenvironment{scalacode}
  { \lstset{language=Scala} }
  {}
\lstnewenvironment{ebnfcode}
  { \lstset{language=ebnf} }
  {}
\lstnewenvironment{nocode}
  { \lstset{language=none} }
  {}
\lstnewenvironment{htmlcode}
  { \lstset{language=html} }
  {}
\lstnewenvironment{html5code}
  { \lstset{language=HTML5} }
  {}
\lstnewenvironment{mplcode}
  { \lstset{language=MPL} }
  {}
\lstnewenvironment{aspectjcode}
  { \lstset{language=[AspectJ]Java} }
  {}
\lstnewenvironment{csharpcode}
  { \lstset{language=[Sharp]C} }
  {}
\lstnewenvironment{ccode}
  { \lstset{language=C} }
  {}
\lstnewenvironment{haskellcode}
  { \lstset{language=Haskell} }
  {}

\RequirePackage{hyperref}

\hypersetup{
  colorlinks=true
}

\RequirePackage{fourier}
\RequirePackage{color}

\definecolor{lightGray}{gray}{0.8}

\lstset{
    numbers=left,   
    stepnumber=1,   
    showspaces=false,
    frame=shadowbox,
    rulesepcolor=\color{lightGray},
    stringstyle=\ttfamily,
    basicstyle=\footnotesize\ttfamily
}
