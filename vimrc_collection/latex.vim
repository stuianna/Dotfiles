"Contains all latex ".tex" file commands, only called if a .tex file is
"opened.

"Automatically open tex files maxamized on LHS, and PDF viewer on RHS
"map <F2> :silent !maxWindowLHS <Enter> :LL<Enter> :sleep 10m <Enter> :silent !maxWindowRHS <Enter> :sleep 10m <Enter> :silent !alttab <Enter> :redraw! <Enter>
map <F2> :LL<Enter> 
set nowrapscan

inoremap \` 
inoremap \1 

"call feedkeys("\<F2>")

"Open cheat sheet
map <F5> <Esc>:silent !olcs<Enter> :redraw!<Enter>
inoremap <F5> <Esc>:silent !olcs<Enter> :redraw!<Enter>
"Open Global references
map <F6> <Esc>:silent !olr<Enter> :redraw!<Enter>
inoremap <F6> <Esc>:silent !olr<Enter> :redraw!<Enter>
"Open Cover Page
map <F7> <Esc>:silent !olcp<Enter> :redraw!<Enter>
inoremap <F7> <Esc>:silent !olcp<Enter> :redraw!<Enter>
"Start auto-compilation
map <F8> <Esc> :LL<Enter>
inoremap <F8> <Esc> :LL<Enter>
map <F9> :StarDictCursor<Enter>

:noremap <F11> :execute "normal! i" . ( line(".") - 1 )<cr>
map <F2> mp1gg:vsplit tags<Enter>:vertical resize 27<Enter><C-W>l <F10>
let @z='/labelww[23~li -> bb yi}hpoldt>xx'
map <F10> 1123@z<Enter>


"Autcompile
map <F3> <Esc> :LL<Enter>
inoremap <F3> <Esc> :LL<Enter>

"list commands
inoremap ;lb \begin{itemize}<Enter>\item <++><Enter>\end{itemize}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;le \begin{enumerate}<Enter>\item <++><Enter>\end{enumerate}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;ls \begin{itemize}[label={}]<Enter>\item <++><Enter>\end{itemize}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;li <Enter>\item 

"equation
inoremap ;en \begin{equation}<Enter><++><Enter>\end{equation}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;el \begin{equation}<Enter>\label{eq:<++>}<Enter><++><Enter>\end{equation}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;ec \begin{figure}[H]<Enter>\begin{equation}<Enter>\label{eq:<++>}<Enter><++><Enter>\end{equation}<Enter>\caption*{<++>}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;ed \begin{figure}[H]<Enter>\begin{equation}<Enter>\label{eq:<++>}<Enter><++><Enter>\end{equation}<Enter>\caption*{<++>}<Enter>\emph{where:}<Enter>\begin{itemize}[label={}]<Enter>\item <++><Enter>\end{itemize}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;es \begin{equation*}<Enter><++><Enter>\end{equation*}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;an \begin{align}<Enter><++> &= <++><Enter>\end{align}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;al \begin{align}<Enter>\label{eq:<++>}<Enter><++> &= <++><Enter>\end{align}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;ac \begin{figure}[H]<Enter>\begin{align}<Enter>\label{eq:<++>}<Enter><++> &= <++><Enter>\end{align}<Enter>\caption*{<++>}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;ad \begin{figure}[H]<Enter>\begin{align}<Enter>\label{eq:<++>}<Enter><++> &= <++><Enter>\end{align}<Enter>\caption*{<++>}<Enter>\emph{where:}<Enter>\begin{itemize}[label={}]<Enter>\item <++><Enter>\end{itemize}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;as \begin{align*}<Enter><++> &= <++><Enter>\end{align*}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;em \begin{split}<Enter><++> &= <++><Enter>\end{split}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;eu \\<Enter><++> &= <++><Esc>gg/<++><Enter>"_c4l
inoremap ;ma $<++>$ <++><Esc>gg/<++><Enter>"_c4l
inoremap ;er _{<++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;ef ^{<++>} <++><Esc>gg/<++><Enter>"_c4l

"Full equation definition
inoremap ;aa \subsubsection{<++>}<Enter>\begin{figure}[H]<Enter>\begin{align*}<Enter><++> &= <++><Enter>\end{align*}<Enter>\emph{where:}<Enter>\begin{table}[H]<Enter>\begin{tabular}{l l l}<Enter>$<++>$ &=& <++> \\ <++><Enter>$<++>$ &=& <++> \\<++><Enter>\end{tabular}<Enter>\end{table}\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;au <Esc>o$<++>$ &=& <++> \\ <++><Esc>gg/<++><Enter>"_c4l


"text modification
inoremap ;te \textbf{<++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;ti \textit{<++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;tu \underline{<++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;ts {\small <++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;tt {\tiny <++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;tl {\large <++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;th {\huge <++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;tL {\Large <++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;tH {\Huge <++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;tn \newline <Esc>o
inoremap ;tq \quad 
inoremap ;tt \text{<++>} <++><Esc>gg/<++><Enter>"_c4l

"sectioning
inoremap ;sj \section{<++>}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;sk \subsection{<++>}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;sm \subsubsection{<++>}<Enter><++><Esc>gg/<++><Enter>"_c4l

"tables my style
"inoremap ;2t \begin{table}[H]<Enter>\centering<Enter>\begin{tabular}{l l}<Enter>\hline<Enter><++> & <++> \\<Enter>\hline<Enter><++> & <++> \\<Enter>\hline<Enter>\end{tabular}<Enter>\label{tab:<++>}<Enter>\caption{<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
"inoremap ;2n <Esc>o<++> & <++> \\<Esc>gg/<++><Enter>"_c4l
"inoremap ;3t \begin{table}[H]<Enter>\centering<Enter>\begin{tabular}{l l l}<Enter>\hline<Enter><++> & <++> & <++> \\<Enter>\hline<Enter><++> & <++> & <++> \\<Enter>\hline<Enter>\end{tabular}<Enter>\label{tab:<++>}<Enter>\caption{<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
"inoremap ;3n <Esc>o<++> & <++> & <++> \\<Esc>gg/<++><Enter>"_c4l
"inoremap ;4t \begin{table}[H]<Enter>\centering<Enter>\begin{tabular}{l l l l}<Enter>\hline<Enter><++> & <++> & <++> & <++> \\<Enter>\hline<Enter><++> & <++> & <++> & <++> \\<Enter>\hline<Enter>\end{tabular}<Enter>\label{tab:<++>}<Enter>\caption{<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
"inoremap ;4n <Esc>o<++> & <++> & <++> &<++> \\<Esc>gg/<++><Enter>"_c4l
"inoremap ;5t \begin{table}[H]<Enter>\centering<Enter>\begin{tabular}{l l l l l}<Enter>\hline<Enter><++> & <++> & <++> & <++> & <++> \\<Enter>\hline<Enter><++> & <++> & <++> & <++> & <++> \\<Enter>\hline<Enter>\end{tabular}<Enter>\label{tab:<++>}<Enter>\caption{<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
"inoremap ;5n <Esc>o<++> & <++> & <++> &<++> & <++> \\<Esc>gg/<++><Enter>"_c4l
"inoremap ;6t \begin{table}[H]<Enter>\centering<Enter>\begin{tabular}{l l l l l l}<Enter>\hline<Enter><++> & <++> & <++> & <++> & <++> & <++> \\<Enter>\hline<Enter><++> & <++> & <++> & <++> & <++> & <++> \\<Enter>\hline<Enter>\end{tabular}<Enter>\label{tab:<++>}<Enter>\caption{<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
"inoremap ;6n <Esc>o<++> & <++> & <++> & <++> &<++> & <++> \\<Esc>gg/<++><Enter>"_c4l

"Tables IAP Style

inoremap ;2t \begin{table}[H]<Enter>\vskip 2.0ex<Enter>\caption{<++>}<Enter>\begin{tabularx}{\textwidth}{l l}<Enter>\hline<Enter><++> & <++> \\<Enter>\hline<Enter><++> & <++> \\<Enter>\hline<Enter>\end{tabularx}<Enter>\label{tab:<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;2n <Esc>o<++> & <++> \\<Esc>gg/<++><Enter>"_c4l
inoremap ;3t \begin{table}[H]<Enter>\vskip 2.0ex<Enter>\caption{<++>}<Enter>\begin{tabularx}{\textwidth}{l l l}<Enter>\hline<Enter><++> & <++> & <++> \\<Enter>\hline<Enter><++> & <++> & <++> \\<Enter>\hline<Enter>\end{tabularx}<Enter>\label{tab:<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;3n <Esc>o<++> & <++> & <++> \\<Esc>gg/<++><Enter>"_c4l
inoremap ;4t \begin{table}[H]<Enter>\vskip 2.0ex<Enter>\caption{<++>}<Enter>\begin{tabularx}{\textwidth}{l l l l}<Enter>\hline<Enter><++> & <++> & <++> & <++>\\<Enter>\hline<Enter><++> & <++> & <++> & <++>\\<Enter>\hline<Enter>\end{tabularx}<Enter>\label{tab:<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;4n <Esc>o<++> & <++> & <++> &<++> \\<Esc>gg/<++><Enter>"_c4l
inoremap ;5t \begin{table}[H]<Enter>\vskip 2.0ex<Enter>\caption{<++>}<Enter>\begin{tabularx}{\textwidth}{l l l l l}<Enter>\hline<Enter><++> & <++> & <++> & <++> & <++>\\<Enter>\hline<Enter><++> & <++> & <++> & <++> & <++>\\<Enter>\hline<Enter>\end{tabularx}<Enter>\label{tab:<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;5n <Esc>o<++> & <++> & <++> &<++> & <++> \\<Esc>gg/<++><Enter>"_c4l
inoremap ;6t \begin{table}[H]<Enter>\vskip 2.0ex<Enter>\caption{<++>}<Enter>\begin{tabularx}{\textwidth}{l l l l l l}<Enter>\hline<Enter><++> & <++> & <++> & <++> & <++> & <++>\\<Enter>\hline<Enter><++> & <++> & <++> & <++> & <++> & <++>\\<Enter>\hline<Enter>\end{tabularx}<Enter>\label{tab:<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;6n <Esc>o<++> & <++> & <++> & <++> &<++> & <++> \\<Esc>gg/<++><Enter>"_c4l

"formulas
inoremap ;ff \frac{<++>}{<++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;fi \int_{<++>}^{<++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;fe e^{<++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;fs \sum_{<++>}^{<++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;fa <Enter>\left\{\begin{array}{ll}<Enter><++> , & \quad <++> \\<Enter>\end{array}\right.<Esc>gg/<++><Enter>"_c4l
inoremap ;fp <Esc>$o<++> , & \quad <++> \\<Esc>gg/<++><Enter>"_c4l
inoremap ;fr \sqrt{<++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;fb \bar{<++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;fl \lim_{<++>} <++><Esc>gg/<++><Enter>"_c4l

"greek letters
inoremap ;ga \alpha  
inoremap ;gb \beta 
inoremap ;gg \gamma 
inoremap ;gG \Gamma 
inoremap ;gd \delta 
inoremap ;gD \Delta 
inoremap ;ge \epsilon 
inoremap ;gn \eta 
inoremap ;gl \lambda 
inoremap ;gm \mu 
inoremap ;gp \pi 
inoremap ;gP \Phi 
inoremap ;gr \rho 
inoremap ;gs \sigma 
inoremap ;gt \tau 
inoremap ;gx \chi 
inoremap ;gw \omega 
inoremap ;gO \Omega 
inoremap ;go \theta 
inoremap ;gz \zeta 
inoremap ;gR \Re

"symbols
inoremap ;si \infty 
inoremap ;sp \partial 
inoremap ;sal \leftarrow 
inoremap ;sar \rightarrow 
inoremap ;sl \leq 
inoremap ;sg \geq 
inoremap ;se \equiv
inoremap ;sn \neq
inoremap ;sap \approx
inoremap ;sd ^{\circ}

"code
inoremap ;cn \begin{figure}[H]<Enter>\lstset{frame=L,basicstyle={\small\ttfamily},numbers=left,tabsize=1,breaklines=true,showstringspaces=false}<Enter>\begin{lstlisting}<Enter><++><Enter>\end{lstlisting}<Enter>\label{cd:<++>}<Enter><++>%\caption{<++>}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;cb \lstset{frame=N,basicstyle={\small\ttfamily},numbers=none,tabsize=1,breaklines=true,showstringspaces=false}<Enter>\begin{lstlisting}<Enter><++><Enter>\end{lstlisting}<Enter><++><Esc>gg/<++><Enter>"_c4l

"figures
inoremap ;bfe \begin{figure}[H]<Enter>\centering<Enter>\captionsetup{justification=centering}<Enter>\includegraphics[width=<++>\linewidth]{<++>}<Enter>\caption{<++>}<Enter>\label{fig:<++>}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;bfn \begin{figure}[H]<Enter>\centering<Enter>\captionsetup{justification=centering}<Enter><++><Enter>\label{fig:<++>}<Enter>\caption{<++>}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l

"minipages
inoremap ;2em \begin{figure}[H]<Enter>\centering<Enter>\begin{minipage}{0.5\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{0.5\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;3em \begin{figure}[H]<Enter>\centering<Enter>\begin{minipage}{0.33\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{0.33\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{0.33\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;4em \begin{figure}[H]<Enter>\centering<Enter>\begin{minipage}{0.25\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{0.25\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{0.25\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{0.25\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;2sm \begin{figure}[H]<Enter>\centering<Enter>\begin{minipage}{0.48\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{0.04\textwidth}<Enter>\hfill<Enter>\end{minipage}%<Enter>\begin{minipage}{0.48\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;3sm \begin{figure}[H]<Enter>\centering<Enter>\begin{minipage}{0.31\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{0.03\textwidth}<Enter>\hfill<Enter>\end{minipage}%<Enter>\begin{minipage}{0.31\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{0.03\textwidth}<Enter>\hfill<Enter>\end{minipage}%<Enter>\begin{minipage}{0.31\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;4sm \begin{figure}[H]<Enter>\centering<Enter>\begin{minipage}{0.22\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{0.04\textwidth}<Enter>\hfill<Enter>\end{minipage}%<Enter>\begin{minipage}{0.22\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{0.04\textwidth}<Enter>\hfill<Enter>\end{minipage}%<Enter>\begin{minipage}{0.22\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{0.04\textwidth}<Enter>\hfill<Enter>\end{minipage}%<Enter>\begin{minipage}{0.22\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;2cm \begin{figure}[H]<Enter>\centering<Enter>\begin{minipage}{<++>\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{<++>\textwidth}<Enter>\hfill<Enter>\end{minipage}%<Enter>\begin{minipage}{<++>\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;3cm \begin{figure}[H]<Enter>\centering<Enter>\begin{minipage}{<++>\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{<++>\textwidth}<Enter>\hfill<Enter>\end{minipage}%<Enter>\begin{minipage}{<++>\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{<++>\textwidth}<Enter>\hfill<Enter>\end{minipage}%<Enter>\begin{minipage}{<++>\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l
inoremap ;4cm \begin{figure}[H]<Enter>\centering<Enter>\begin{minipage}{<++>\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{<++>\textwidth}<Enter>\hfill<Enter>\end{minipage}%<Enter>\begin{minipage}{<++>\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{<++>\textwidth}<Enter>\hfill<Enter>\end{minipage}%<Enter>\begin{minipage}{<++>\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}%<Enter>\begin{minipage}{<++>\textwidth}<Enter>\hfill<Enter>\end{minipage}%<Enter>\begin{minipage}{<++>\textwidth}<Enter>\centering<Enter><++><Enter>\end{minipage}<Enter>\end{figure}<Enter><++><Esc>gg/<++><Enter>"_c4l

"columns
inoremap ;mc \begin{multicols}{<++>}<Enter><++><Enter>\end{multicols}<Esc>gg/<++><Enter>"_c4l

"referencing
inoremap ;re \eqref{eq:<++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;rt \ref{<++>} <++><Esc>gg/<++><Enter>"_c4l
inoremap ;rr \cite{<++>} <++><Esc>gg/<++><Enter>"_c4l
