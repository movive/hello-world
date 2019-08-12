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

\RequirePackage{tabularx}

\RequirePackage{multirow}

\RequirePackage{mdframed}

\RequirePackage{array}

\RequirePackage{lipsum}

\RequirePackage{setspace}

\RequirePackage{graphicx}
\RequirePackage{caption}
\RequirePackage[utf8]{datatool}
\RequirePackage{lscape}
\RequirePackage{longtable}
%\RequirePackage[backend=bibtex,style=verbose-trad2]{biblatex}
%\RequirePackage{biblatex}
%\RequirePackage{color}
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
\setlength{\textwidth}{160mm}% set required text width first
\setlength{\hoffset}{0mm}% set horizontal offset
\ifsound@print% if print layout enabled
    \setlength{\oddsidemargin}{0mm}% binding side margin
    \setlength{\evensidemargin}{0mm}% ensure uniform binding side width for printing
\else
    \setlength{\oddsidemargin}{0mm}% left side margin
    \setlength{\evensidemargin}{0mm}% ensure uniform left side width for EThesis
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
%
%\title{title}{subtitle}
%---总体信息
\def\sound@value@ch@title{}
\def\sound@value@ch@subtitle{}
\renewcommand{\title}[2]{%
    \def\sound@value@ch@title{#1}
    \def\sound@value@ch@subtitle{#2}}
\def\sound@value@ch@project{}
\newcommand{\project}[1]{\def\sound@value@ch@project{#1}}
\newcommand{\showproject}{\sound@value@ch@project}
\def\sound@value@ch@project@location{}
\newcommand{\projectlocation}[1]{\def\sound@value@ch@project@location{#1}}
\newcommand{\showprojectlocation}{\sound@value@ch@project@location}
\def\sound@value@ch@project@id{}
\newcommand{\id}[1]{\def\sound@value@ch@project@id{#1}}
\def\sound@value@ch@project@name{}
\newcommand{\projectname}[1]{\def\sound@value@ch@project@name{#1}}
\def\sound@value@ch@manager{}
\newcommand{\manager}[1]{\def\sound@value@ch@manager{#1}}
\def\sound@value@ch@department{}
\newcommand{\department}[1]{\def\sound@value@ch@department{#1}}
\def\sound@value@ch@applydate{}
\newcommand{\applydate}[1]{\def\sound@value@ch@applydate{#1}}
\newcommand{\showapplydate}{\sound@value@ch@applydate}
\def\sound@value@ch@company{}
\newcommand{\company}[1]{\def\sound@value@ch@company{#1}}
\def\sound@value@ch@manager@gender{}
\newcommand{\managergender}[1]{\def\sound@value@ch@manager@gender{#1}}
\def\sound@value@ch@manager@birth{}
\newcommand{\managerbirth}[1]{\def\sound@value@ch@manager@birth{#1}}
\def\sound@value@ch@manager@ethnic{}
\newcommand{\managerethnic}[1]{\def\sound@value@ch@manager@ethnic{#1}}
\def\sound@value@ch@manager@degree{}
\newcommand{\managerdegree}[1]{\def\sound@value@ch@manager@degree{#1}}
\def\sound@value@ch@manager@title{}
\newcommand{\managertitle}[1]{\def\sound@value@ch@manager@title{#1}}
\def\sound@value@ch@manager@area{}
\newcommand{\managerarea}[1]{\def\sound@value@ch@manager@area{#1}}
\def\sound@value@ch@manager@telephone{}
\newcommand{\managertelephone}[1]{\def\sound@value@ch@manager@telephone{#1}}
\def\sound@value@ch@manager@email{}
\newcommand{\manageremail}[1]{\def\sound@value@ch@manager@email{#1}}

%---开题信息
\def\sound@value@ch@attendant{}
\newcommand{\attendant}[1]{\def\sound@value@ch@attendant{#1}}
\def\sound@value@ch@expectperiod{}
\newcommand{\expectperiod}[1]{\def\sound@value@ch@expectperiod{#1}}
\def\sound@value@ch@fund{}
\newcommand{\fund}[1]{\def\sound@value@ch@fund{#1}}
\def\sound@value@ch@fundtype{}
\newcommand{\fundtype}[1]{\def\sound@value@ch@fundtype{#1}}
\def\sound@value@ch@achievement@middle{}
\newcommand{\achievementmiddle}[1]{\def\sound@value@ch@achievement@middle{#1}}
\def\sound@value@ch@achievement@final{}
\newcommand{\achievementfinal}[1]{\def\sound@value@ch@achievement@final{#1}}
\def\sound@value@ch@project@area{}
\newcommand{\projectarea}[1]{\def\sound@value@ch@project@area{#1}}
\def\sound@value@ch@project@direction{}
\newcommand{\projectdirection}[1]{\def\sound@value@ch@project@direction{#1}}
\def\sound@value@ch@project@abstract{}
\newcommand{\projectabstract}[1]{\def\sound@value@ch@project@abstract{#1}}

%---结题信息
\def\sound@value@ch@attendantchanged{}
\newcommand{\attendantchanged}[1]{\def\sound@value@ch@attendantchanged{#1}}
\def\sound@value@ch@actualperiod{}
\newcommand{\actualperiod}[1]{\def\sound@value@ch@actualperiod{#1}}
\def\sound@value@ch@actualfund{}
\newcommand{\actualfund}[1]{\def\sound@value@ch@actualfund{#1}}
\def\sound@value@ch@actualfundtype{}
\newcommand{\actualfundtype}[1]{\def\sound@value@ch@actualfundtype{#1}}
\def\sound@value@ch@actualachievement@middle{}
\newcommand{\actualachievementmiddle}[1]{\def\sound@value@ch@actualachievement@middle{#1}}
\def\sound@value@ch@actualachievement@final{}
\newcommand{\actualachievementfinal}[1]{\def\sound@value@ch@actualachievement@final{#1}}
\def\sound@value@ch@project@jietiabstract{}
\newcommand{\jietiabstract}[1]{\def\sound@value@ch@project@jietiabstract{#1}}




%-
%-> Redefine Chinese style
%-
\renewcommand{\maketitle}{%
    \cleardoublepage
    \thispagestyle{empty}    
    \begin{flushright}
        \zihao{-3}\bfseries
        \vspace*{5pt}
        \sound@label@ch@project@id：\ulenhance[1pt]{\ulextend[100pt]{\sound@value@ch@project@id}}
    \end{flushright}
        \begin{center}
        \linespread{1.3}
        \zihao{-3}\bfseries
        \vspace*{110pt}

        {%
            \zihao{1}
            \sound@value@ch@title
        }

        \vspace*{20pt}

        {\zihao{3}\bfseries\sffamily \sound@value@ch@subtitle}
        
        \vspace*{205pt}
        \begin{tabular}{ m{32mm} m{120mm} }
            \sound@label@ch@project@name：& \ulenhance[1pt]{\ulextend[100mm]{\qquad\sound@value@ch@project@name}}\\
            \sound@label@ch@manager：& \ulenhance[1pt]{\ulextend[100mm]{\sound@value@ch@manager}}\\
            \sound@label@ch@department：& \ulenhance[1pt]{\ulextend[100mm]{\sound@value@ch@department}}\\
            \sound@label@ch@applydate：& \ulenhance[1pt]{\ulextend[100mm]{\sound@value@ch@applydate}}
        \end{tabular}

        \vspace*{100pt}
        {\sound@value@ch@company}

    \end{center}
    \clearpage
}
%-> 制作报告封面
\newcommand{\makereporttitle}{%
    \cleardoublepage
    \thispagestyle{empty}    
    \begin{flushleft}
        \zihao{4}
        \vspace*{5pt}
        附件：
    \end{flushleft}
    \begin{center}
        \linespread{1.3}
        \zihao{-3}\bfseries
        \vspace*{110pt}

        {%
            \zihao{1}
            \sound@value@ch@title
        }

        \vspace*{20pt}

        {\zihao{3}\bfseries\sffamily \sound@value@ch@subtitle}
        
        \vspace*{245pt}
        \begin{tabular}{ m{30mm} m{100mm} }
            \sound@label@ch@project@name：& \ulenhance[1pt]{\ulextend[100mm]{\quad\sound@value@ch@project@name}}\\
            \sound@label@ch@reportdate：& \ulenhance[1pt]{\ulextend[100mm]{\sound@value@ch@applydate}}
        \end{tabular}

        \vspace*{160pt}
        {\sound@value@ch@company}

    \end{center}
    \clearpage
}

%-> make various tables
\newcolumntype{L}[1]{>{\hsize=#1\hsize\raggedright\arraybackslash}X}%
\newcolumntype{R}[1]{>{\hsize=#1\hsize\raggedleft\arraybackslash}X}%
\newcolumntype{C}[1]{>{\hsize=#1\hsize\centering\arraybackslash}X}%
%-> 制作开题表格
\newcommand{\makebasicinfo}{%
    \raggedleft{%
    % addjust row height
    \renewcommand{\arraystretch}{1.4}
    \begin{tabular}{|m{6mm}<{\centering}|m{6mm}<{\centering}|m{15mm}<{\centering}|m{14mm}<{\centering}|m{12mm}<{\centering}|m{5mm}<{\centering}|m{16mm}<{\centering}|m{18mm}<{\centering}|m{12mm}<{\centering}|m{6mm}|}
        \hline        \multirow{4}{6mm}{项目人员信息} & \multirow{3}{6mm}{\sound@label@ch@manager} & \sound@label@ch@manager@name      & \sound@value@ch@manager         & \sound@label@ch@manager@gender & \sound@value@ch@manager@gender & \sound@label@ch@manager@birth & \sound@value@ch@manager@birth & \sound@label@ch@manager@ethnic & \multicolumn{1}{c|}{\sound@value@ch@manager@ethnic} \\
        \cline{3-10}                                 &                                            & \sound@label@ch@manager@degree    & \sound@value@ch@manager@degree  & \sound@label@ch@manager@title  & \multicolumn{2}{l|}{\sound@value@ch@manager@title}              & \sound@label@ch@manager@area  & \multicolumn{2}{l|}{\sound@value@ch@manager@area}                \\
        \cline{3-10}                                 &                                            & \sound@label@ch@manager@telephone & \multicolumn{2}{l|}{\sound@value@ch@manager@telephone}            & \multicolumn{2}{l|}{\sound@label@ch@manager@email}              & \multicolumn{3}{l|}{\sound@value@ch@manager@email}\\
        \cline{2-10}                                 & \multicolumn{2}{l|}{\sound@label@ch@attendant}                                & \multicolumn{7}{l|}{\sound@value@ch@attendant}\\
        \hline        \multirow{3}{6mm}{合作单位} & \multicolumn{2}{l|}{单位名称} & \multicolumn{2}{l|}{} & \multicolumn{2}{l|}{联系人}   & \multicolumn{3}{l|}{} \\
        \cline{2-10}                                  & \multicolumn{2}{l|}{单位性质} & \multicolumn{2}{l|}{} & \multicolumn{2}{l|}{电话}     & \multicolumn{3}{l|}{} \\
        \cline{2-10}                                  & \multicolumn{2}{l|}{合作方式} & \multicolumn{2}{l|}{} & \multicolumn{2}{l|}{电子邮箱} & \multicolumn{3}{l|}{}\\
        \hline        \multirow{7}{6mm}{项目基本信息}  & \multicolumn{2}{l|}{\sound@label@ch@project@name}      & \multicolumn{7}{l|}{\sound@value@ch@project@name} \\
        \cline{2-10}                                  & \multicolumn{2}{l|}{\sound@label@ch@project@area}      & \multicolumn{7}{l|}{\sound@value@ch@project@area} \\
        \cline{2-10}                                  & \multicolumn{2}{l|}{\sound@label@ch@project@direction} & \multicolumn{7}{l|}{\sound@value@ch@project@direction} \\
        \cline{2-10}                                  & \multicolumn{2}{l|}{\multirow{2}{21mm}{\sound@label@ch@expectperiod}} & \multicolumn{2}{l|}{\multirow{2}{26mm}{\sound@value@ch@expectperiod}} & \multicolumn{2}{l|}{\sound@label@ch@fundtype} & \multicolumn{3}{l|}{\sound@value@ch@fundtype} \\
        \cline{6-10}                                  & \multicolumn{2}{l|}{}                                                 & \multicolumn{2}{l|}{}                                                 & \multicolumn{2}{l|}{\sound@label@ch@fund} & \multicolumn{3}{l|}{\sound@value@ch@fund} \\  
        \cline{2-10}                                  & \multicolumn{2}{l|}{\multirow{2}{21mm}{\sound@label@ch@achievement}} & \multicolumn{7}{l|}{\sound@value@ch@achievement@middle}\\
        \cline{4-10}                                  & \multicolumn{2}{l|}{}                                                & \multicolumn{7}{l|}{\sound@value@ch@achievement@final}\\
        \hline        \multirow{4}{6mm}{\sound@label@ch@project@abstract} & \multicolumn{9}{l|}{\multirow{4}{146mm}{\sound@value@ch@project@abstract}}\\
        & \multicolumn{9}{l|}{}\\
        & \multicolumn{9}{l|}{}\\
        & \multicolumn{9}{l|}{}\\
        & \multicolumn{9}{l|}{}\\
   %     & \multicolumn{9}{l|}{}\\
        \hline
    \end{tabular}
    }
}
%-> 制作中期进展表头
\newcommand{\makezhongqiinfo}{
    \begin{center}
        \linespread{1.3}
        \zihao{-3}\bfseries
        \sound@value@ch@title
    \end{center}
    \begin{tabular}{|m{40mm}|m{30mm}|m{30mm}|m{42.9mm}|}
        \hline    \sound@label@ch@project@name & \multicolumn{3}{c|}{\sound@value@ch@project@name} \\
        \hline    \sound@label@ch@expectperiod & \multicolumn{3}{c|}{\sound@value@ch@expectperiod} \\
        \hline    \sound@label@ch@manager & \sound@value@ch@manager & \sound@label@ch@applydate & \sound@value@ch@applydate \\ 
    \end{tabular}
}
%-> 制作结题项目信息表
\newcommand{\makejietiinfo}{
    \raggedleft{%
    % addjust row height
    \renewcommand{\arraystretch}{1.4}
    \begin{tabular}{|m{6mm}<{\centering}|m{6mm}<{\centering}|m{15mm}<{\centering}|m{14mm}<{\centering}|m{12mm}<{\centering}|m{5mm}<{\centering}|m{16mm}<{\centering}|m{18mm}<{\centering}|m{12mm}<{\centering}|m{6mm}|}
        \hline        \multirow{4}{6mm}{项目人员信息} & \multirow{3}{6mm}{\sound@label@ch@manager} & \sound@label@ch@manager@name      & \sound@value@ch@manager         & \sound@label@ch@manager@gender & \sound@value@ch@manager@gender & \sound@label@ch@manager@birth & \sound@value@ch@manager@birth & \sound@label@ch@manager@ethnic & \multicolumn{1}{c|}{\sound@value@ch@manager@ethnic} \\
        \cline{3-10}                                 &                                            & \sound@label@ch@manager@degree    & \sound@value@ch@manager@degree  & \sound@label@ch@manager@title  & \multicolumn{2}{l|}{\sound@value@ch@manager@title}              & \sound@label@ch@manager@area  & \multicolumn{2}{l|}{\sound@value@ch@manager@area}                \\
        \cline{3-10}                                 &                                            & \sound@label@ch@manager@telephone & \multicolumn{2}{l|}{\sound@value@ch@manager@telephone}            & \multicolumn{2}{l|}{\sound@label@ch@manager@email}              & \multicolumn{3}{l|}{\sound@value@ch@manager@email}\\
        \cline{2-10}                                 & \multicolumn{2}{l|}{\sound@label@ch@attendantchanged}                          & \multicolumn{7}{l|}{\sound@value@ch@attendantchanged}\\
        \hline        \multirow{5}{6mm}{项目基本信息}  & \multicolumn{2}{l|}{\sound@label@ch@project@name}      & \multicolumn{7}{l|}{\sound@value@ch@project@name} \\
        \cline{2-10}                                  & \multicolumn{2}{l|}{\multirow{2}{21mm}{\sound@label@ch@actualperiod}} & \multicolumn{2}{l|}{\multirow{2}{26mm}{\sound@value@ch@actualperiod}} & \multicolumn{2}{l|}{\sound@label@ch@actualfundtype} & \multicolumn{3}{l|}{\sound@value@ch@actualfundtype} \\
        \cline{6-10}                                  & \multicolumn{2}{l|}{}                                                 & \multicolumn{2}{l|}{}                                                 & \multicolumn{2}{l|}{\sound@label@ch@actualfund} & \multicolumn{3}{l|}{\sound@value@ch@actualfund} \\  
        \cline{2-10}                                  & \multicolumn{2}{l|}{\multirow{2}{21mm}{\sound@label@ch@actualachievement}} & \multicolumn{7}{l|}{\sound@value@ch@actualachievement@middle}\\
        \cline{4-10}                                  & \multicolumn{2}{l|}{}                                                & \multicolumn{7}{l|}{\sound@value@ch@actualachievement@final}\\
        \hline        \multirow{4}{6mm}{\sound@label@ch@project@jietiabstract} & \multicolumn{9}{l|}{\multirow{4}{146mm}{\sound@value@ch@project@jietiabstract}}\\[60mm]
        & \multicolumn{9}{l|}{}\\
        & \multicolumn{9}{l|}{}\\
        & \multicolumn{9}{l|}{}\\
        & \multicolumn{9}{l|}{}\\
   %     & \multicolumn{9}{l|}{}\\
        \hline
    \end{tabular}
    }
}
%---------------------------------------------------------------------------%
%->> Structure elements configuration
%---------------------------------------------------------------------------%
%- section
\ctexset {
    section = {
        format = \raggedright\zihao{4}\sffamily,
        number = {\chinese{section}、},
        aftername = {},
        beforeskip = {24pt},
        afterskip = {6pt},
    }
}
%- subsection
\ctexset {
    subsection = {
        format = \sffamily,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {12pt},
        afterskip = {6pt},
    }
}
%- subsubsection
\ctexset {
    subsubsection = {
        format = \sffamily,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {12pt},
        afterskip = {6pt},
    }
}