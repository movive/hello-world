%->> Required TeXFormat and Provided class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{soundresearch}[2019/05/01 v1.0 LaTeX document]
%->> Declare options
%-> Layout
\DeclareOption{oneside}{
    \PassOptionsToClass{oneside}{ctexart}
}
\DeclareOption{twoside}{%
    \PassOptionsToClass{twoside}{ctexart}%
}
\newif\ifsound@print \sound@printfalse
\DeclareOption{print}{%
    \PassOptionsToClass{twoside}{ctexart}%
    \sound@printtrue%
}
%-> Language
\newif\ifsound@versioninfo \sound@versioninfofalse
\DeclareOption{draftversion}{
    \sound@versioninfotrue
}
%-> Handle non-implemented options
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{ctexart}
}
%-> Terminates all options processing
\ProcessOptions\relax
%
%->> Load class information
%
\LoadClass[UTF8,a4paper,zihao=-4]{ctexart}
%
%->> Required packages
%
\RequirePackage{ifxetex}
%
%->> Load class configuration
%
\AtEndOfPackage{%class cfg loaded after package to make preamble commands take effect
    \makeatletter
    \InputIfFileExists{Style/soundresearch.cfg}{}{}
    \makeatother
}
%
%->> Page layout
%
%- use \topmargin insead of \voffset to shift the complete text vertically
%- use \<odd|even>sidemargin insead of \hoffset to shift text horizontally
%- part one -- horizontal widths
%- left side width + textwidth + right side width = paperwidth
%- binding side width + textwidth + nonbinding side width = paperwidth
%- binding side width of [odd, even] page = [left, right] side width
%- left side width of [odd, even] page = 1.0in (fixed) + hoffset + [odd, even]sidemargin
%- assuming A4 paper (210mm x 297mm)
\setlength{\textwidth}{146.6mm}% set required text width first
\setlength{\hoffset}{0mm}% set horizontal offset
\ifsound@print% if print layout enabled
    \setlength{\oddsidemargin}{12.6mm}% binding side margin
    \setlength{\evensidemargin}{0mm}% ensure uniform binding side width for printing
\else
    \setlength{\oddsidemargin}{6.3mm}% left side margin
    \setlength{\evensidemargin}{6.3mm}% ensure uniform left side width for EThesis
\fi
%\setlength{\marginparwidth}{35pt}% width of margin notes
%\setlength{\marginparsep}{10pt}% width of space between body text and margin notes
\setlength{\marginparwidth}{0pt}% width of margin notes
\setlength{\marginparsep}{0pt}% width of space between body text and margin notes
%- part two -- vertical heights
%- top height + textheight + bottom height = paperheight
%- top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep 
\setlength{\textheight}{246.2mm}% set required text height first
\setlength{\voffset}{0mm}% set vertical offset
\setlength{\topmargin}{-10.4mm}% vertical margin above header
\setlength{\headheight}{12pt}% header height
\setlength{\headsep}{17.5pt}% vertical margin between header and body text
\setlength{\footskip}{10.4mm}% vertical margin between footer and body text
%- specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%- line spacing
\linespread{1.6}% line space setting
\raggedbottom% prevent adding vertical white space in strange places
%- default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%
%->> Style control commands
%
%- redefine cleardoublepage to have page style argument
\renewcommand{\cleardoublepage}[1][plain]{%
    \clearpage\if@twoside\ifodd\c@page\else%
    \thispagestyle{#1}%
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}
%- underline
\ifxetex%
    %\RequirePackage{ulem}% loaded by xeCJKfntef
\else%
    \RequirePackage{ulem}%
\fi
\newcommand{\ulunify}[1]{\uline{#1}}% unified name
\newcommand{\ulenhance}[2][1pt]{% enhanced underline
    \def\ULthickness{#1}% set thickness
    \setlength{\ULdepth}{0.3em}% set depth
    \expandafter\ulunify\expandafter{#2}% linebreak fix
}
\newcommand{\ulhshift}{-3em}% horizontal shift on underline
\newcommand{\ulextend}[2][350pt]{% extend underline length
    \hbox to #1{\hfill\hspace*{\ulhshift}#2\hfill}}
%- special cell
%- \specialcell[<align2>]{align1}{text1\\text2};
%- <align1>: t,c,b; <align2> l,c,r; @{} suppress spaces before and after text 
\newcommand{\specialcell}[3][c]{%
    \begin{tabular}[#2]{@{}#1@{}}#3\end{tabular}}
%
%->> Titlepage
%
%-> Chinese item commands
