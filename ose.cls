\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ose}[2023/04/05 class to match Old-School-Essential RPG documents]

%% report to have chapter on one column and the rest of document on two.
\LoadClass[10pt,a5paper,twocolumn, ,twoside]{report}

% force correct page layout
\RequirePackage{geometry}
\geometry{
    a5paper,
    left=7mm,
    right=7mm,
    top=7mm,
    bottom=9mm,
    footskip=15pt
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% COLORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\PassOptionsToPackage{usenames,dvipsnames,x11names,table}{xcolor} % required to avoid option clash in color and table
\RequirePackage{xcolor}

\definecolor{osegreen}{HTML}{d8e9d2}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FONTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{fontspec}

%% default text font
\setmainfont[
    Path = ./fonts/,
    UprightFont    = Minion-Pro-Regular,
    BoldFont       = Minion-Pro-Bold,
    ItalicFont     = Minion-Pro-Italic,
    BoldItalicFont = Minion-Pro-Bold-Italic,
    Extension      = .ttf,
]{textfont}

% other, for heading and sections
\newfontfamily\headerfont{Council}[
    Path = ./fonts/,
    Extension       =   .ttf,
    UprightFont     =   Council-Regular,
]
\newfontfamily\Economica{Economica}[
    Path = ./fonts/,
    Extension      = .ttf,
    UprightFont    = Economica-Regular,
    BoldFont       = Economica-Bold,
    ItalicFont     = Economica-Italic,
    BoldItalicFont = Economica-Bold-Italic,
]
\newfontfamily\sectionfont{Futura-Condensed}[
    Path = ./fonts/,
    UprightFont     =   Futura-Condensed.ttf,
    BoldFont        =   Futura-Condensed-Bold.otf,
]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Title page definition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{tikz}
\RequirePackage[skins]{tcolorbox}
\usetikzlibrary{positioning, calc, shapes.misc}

\newcommand{\usecovercolor}{gray}
\newcommand{\covercolor}[1]{%
    \renewcommand{\usecovercolor}{#1}%
}

\newcommand{\usecoverimage}{img/placeholder.jpg}
\newcommand{\coverimage}[1]{%
    \renewcommand{\usecoverimage}{#1}%
}

\renewcommand{\maketitle}{
  \thispagestyle{empty}
\begin{tikzpicture}[remember picture,overlay, shift=(current page.south west)]
    \begin{scope}[x={(current page.south east)},y={(current page.north west)}]
        \node[fill=\usecovercolor,minimum width=\paperwidth, minimum height=\paperheight] at (0.5,0.5) {};
        \node [
            color=white,draw,line width=1.5mm,
            chamfered rectangle,
            chamfered rectangle angle=30,
            chamfered rectangle ysep=1cm,
            minimum width=0.7\paperwidth,
            minimum height=0.7\paperheight,
            fill overzoom image=\usecoverimage
        ] at (0.5, 0.45) {};
        \node [] at (0.5, 0.9)      {
            \includegraphics[width=0.6\paperwidth]{img/Designed_For_Use_With_Old-School_Essentials.png}
        };
        \node [] at (0.5, 0.05) {
            \Economica\fontsize{30pt}{37pt}\selectfont\color{white}\bfseries\contour[128]{black}{\@title}
        };
    \end{scope}
\end{tikzpicture}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% section definition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[explicit]{titlesec}
\RequirePackage{titletoc}
\RequirePackage{graphicx}

\RequirePackage{calc}
\RequirePackage{xparse}
\RequirePackage[]{contour}
\RequirePackage[]{adjustbox}



\renewcommand{\tableofcontents}{%
    \chapter*{\contentsname
        \@mkboth{%
            \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
}
\setcounter{tocdepth}{1}

\newlength\chapterheight
\setlength{\chapterheight}{0.3\paperheight}

\newcommand{\includechapterbackground}{}
\newcommand{\chapterbackground}[1]{%
    \renewcommand{\includechapterbackground}{
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north east, inner sep=0pt] (back) at (current page.north east) {\includegraphics[width=\paperwidth]{#1}};
            \node[] (rule) at (back.south) {{\color{osegreen}\rule{\paperwidth}{2mm}}};
        \end{tikzpicture}
    }
    \setlength{\chapterheight}{\heightof{\includegraphics[width=\paperwidth]{#1}}}
    \settextstartoffset
}

\newlength\textstartoffset
\newcommand{\settextstartoffset}{
    \setlength{\textstartoffset}{\chapterheight}
    \addtolength{\textstartoffset}{-\headheight}
    \addtolength{\textstartoffset}{-\headsep}
    \addtolength{\textstartoffset}{-2mm}
}

\chapterbackground{img/chapter-default.png}

\newcommand{\printchaptertitle}[1]{%
   \begin{tikzpicture}[remember picture, overlay]
     \node[anchor=north east, inner sep=0pt, minimum width=\paperwidth, minimum height=\chapterheight] at (current page.north east) {%
         % avoid overfull in case of too long title
         \adjustbox{max width=\textwidth}{\centering\contour[128]{white}{#1}}%
     };
    \end{tikzpicture}
}

\titleformat{\chapter}[display]
  {\centering\headerfont\fontsize{60pt}{70pt}\selectfont}
  {%
      \includechapterbackground%
  }
  {-70pt}
  {\printchaptertitle{#1}}

\titleformat{name=\chapter,numberless}
  {\centering\headerfont\fontsize{60pt}{70pt}\selectfont}
  {\includechapterbackground}
  {-70pt}
  {\printchaptertitle{#1}}

\titlespacing*{\chapter}{0pt}{-35pt}{\textstartoffset}

%\contentsmargin{-4em}
\titlecontents{chapter}[0pt]% adjust left margin
    {\bfseries\large}% font formatting above-code
    {}
    {}
    {\titlerule*{~}\contentspage}
    [\vspace*{-3pt}\hrule\vspace*{10pt}]

\titleformat{\section}{\headerfont\fontsize{34pt}{40pt}\selectfont}{}{0pt}{#1}
\titleformat{name=\section,numberless}{\headerfont\fontsize{34pt}{40pt}\selectfont}{}{0pt}{#1}

\titlecontents{section}[2em]% adjust left margin
{}% font formatting above-code
{}
{}
{\hfill\contentspage}
[]

\titleformat{\subsection}[block]
  {\sectionfont\fontsize{16pt}{19pt}\selectfont}
  {\rlap{\color{osegreen}\rule[-8pt]{\columnwidth}{24pt}}}
  {0pt}
  {~~#1}

\titleformat{name=\subsection,numberless}[block]
  {\sectionfont\fontsize{16pt}{19pt}\selectfont}
  {\rlap{\color{osegreen}\rule[-8pt]{\columnwidth}{24pt}}}
  {0pt}
  {~~#1}

%\large=12pt (normalsize=10pt)
\titleformat{\subsubsection}{\large\bfseries}{}{0pt}{#1}
\titleformat{name=\subsubsection,numberless}{\large\bfseries}{}{0pt}{#1}


%% no paragraph indent
\newlength{\oseitemindent}
\setlength{\oseitemindent}{\parindent}
\setlength{\parindent}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Lists definition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{enumitem}
\RequirePackage{amssymb}

\setlist{nosep, partopsep=6pt}
\setlist[itemize,1]{wide = 0pt, label=$\blacktriangleright$}
\setlist[itemize,2]{leftmargin=2\oseitemindent, itemindent=\oseitemindent, label=$\bullet$}
\setlist[itemize,3]{leftmargin=\oseitemindent, itemindent=\oseitemindent, label=$\circ$}
\setlist[itemize,4]{leftmargin=\oseitemindent, itemindent=\oseitemindent}

\setlist[enumerate,1]{label=\textbf{\arabic*}.}
\setlist[enumerate,2]{label=\textbf{\alph*}.}
\setlist[enumerate,3]{label=\textbf{\roman*}.}
\setlist[enumerate,4]{label=\textbf{\roman{enumiii}}.\textbf{\arabic*}.}

\setlist[description,1]{wide = 0pt}
\setlist[description,2]{leftmargin=\oseitemindent, itemindent=\oseitemindent}
\setlist[description,3]{leftmargin=\oseitemindent, itemindent=\oseitemindent}
\setlist[description,4]{leftmargin=\oseitemindent, itemindent=\oseitemindent}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Footer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{fancyhdr}

\newcommand*\circled[1]{\tikz[baseline=(char.base)]{
        \node[shape=circle,fill=osegreen,inner sep=2pt] (char) {#1};}
}
\pagestyle{fancy}
\fancyhead{}
\fancyfoot[LE,RO]{\circled{\thepage}}
\fancyfoot[C]{}
\renewcommand{\headrulewidth}{0pt}

\fancypagestyle{plain}{%
    \fancyhf{}
    \fancyfoot[LE,RO]{\circled{\thepage}}
    \fancyfoot[C]{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%	Table style
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{etoolbox}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{tabularray}


\newcommand{\rowstyle}[1]{\gdef\rowstyle{#1}%
    #1\ignorespaces
}

\newcommand*{\arraycolor}[1]{\protect\leavevmode\color{#1}}

\rowcolors{1}{}{osegreen}

\NewTblrTheme{ose}{
    \SetTblrStyle{firsthead}{font=\bfseries}
}

\newenvironment{osetable}[2]
    {
        \ifstrequal{#2}{0}{
            \tblr[theme=ose]{
                colspec = {#1},
                row{even}=osegreen,
            }
        }{%
            \tblr[theme=ose]{
                colspec = {#1},
                row{even}=osegreen,
                row{1-#2} = {font=\bfseries\large\sectionfont},
                hline{\the\numexpr#2+1\relax} = {1pt},
            }
        }
    }{ \endtblr}

\gdef\header{%
    \SetRow{font=\bfseries\large\sectionfont} %
}

%% caption style
\RequirePackage{caption}    % for customized caption

\DeclareCaptionFont{osecaption}{\bfseries\large\sectionfont}
\captionsetup[table]{
    singlelinecheck=false,
    position=below,
    box=colorbox,
    boxcolor=black,
    font = {
        osecaption,
        color=white
    },
    justification=raggedright
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%	LINKS style
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{hyperref}   % for hyperlink customization
\hypersetup{
    colorlinks=true,
    urlcolor=blue,
    linkcolor=black,
    citecolor=red,
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%	highlight box style
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\tcbuselibrary{breakable}

\newtcolorbox{highlight}[1][]{
    breakable,
    colback=osegreen,
    colbacktitle=osegreen,
    coltitle=black,
    fonttitle=\bfseries\large,
    bottomrule=0pt,
    toprule=0pt,
    leftrule=0pt,
    rightrule=0pt,
    titlerule=0pt,
    arc=0pt,
    outer arc=0pt,
    title=#1,
    left=2pt,right=2pt,top=0pt,bottom=0pt
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% for HP squares in monster description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcount\my@repeat@count
\newcommand{\repeatit}[3]{%
  % #1 = number of repetition
  % #2 = text to repeat
  % #3 = text in between
  \begingroup%
  #2%
  \my@repeat@count=\@ne%
  \@whilenum\my@repeat@count<#1\do{#2#3\advance\my@repeat@count\@ne}%
  \endgroup%
}
\newcommand{\oneHD}{{\small$\square\square\square\square\square\square\square\square$ }}
\newcommand{\hdsquares}[1]{\repeatit{#1}{\oneHD}{}}
