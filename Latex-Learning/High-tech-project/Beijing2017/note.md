* variable needed to notice

    * uas@print->sound@print

[ ] emurate participatee members and add them into table
[ ] how to create page layout
[ ] how to format table
[x] understand how to create a maro and what "\newcommand" means

* tip on how to create boxed text -- create a new environment and warp all in a single row table
```Latex
\newenvironment{boxednote}{\begin{center}\em% 
\begin{tabular}{|p{0.8\textwidth}|}\hline}% 
{\\ \hline\end{tabular}\end{center}}
```
usecase:
```Latex
\begin{boxednote} 
This is a new environment for … 
\end{boxednote}
```
this method, however, cannot include multiple paragraphs or even a line break.
* interesting notice: within the creation of a new environment, one can create a `\renewcommand` to confine its usage within the environment scope. like:
```Latex
\newenvironment{itemem} {\begin{itemize}\renewcommand{\labelitemi}{\checkmark}}{\end{itemize}}
```
changes bullet symbol from default into checkmark

