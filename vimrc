
""""""""""	Plugins
set rtp+=~/.vim/bundle/Vundle.vim																			" set the runtime path to include Vundle and initialize

call vundle#begin()
Plugin 'LaTeX-Box-Team/LaTeX-Box'																			" For latex compile
Plugin 'xuhdev/vim-latex-live-preview'																" For latex live preview
"Plugin 'Valloric/YouCompleteMe'																				" Code completion engine.
Plugin 'scrooloose/nerdtree'																					" Vim file browser
Plugin 'jistr/vim-nerdtree-tabs'																			" Better tab handling for nerd-tree
Plugin 'Xuyuanp/nerdtree-git-plugin'																	" Show git status in nerdtree
Plugin 'vim-airline/vim-airline'																			" Status line and tag line
Plugin 'scrooloose/nerdcommenter'																			" Commenting plugin
Plugin 'majutsushi/tagbar'																						" Tagbar
Plugin 'tpope/vim-fugitive'																						" Git wrapper for git inside of vim
Plugin 'airblade/vim-gitgutter'																				" Show git status in numbers line
Plugin 'ludovicchabant/vim-gutentags'																	" Use tags to zip through source files.
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'skywind3000/asyncrun.vim'																			" Background task handling
call vundle#end()   



""""""""""	General Vim Settings	
set relativenumber																										" Set relative line numbers
colo desert																														" Colorscheme
set nocompatible
syntax on																															" Syntax highlighting
set encoding=UTF-8
set updatetime=100 																										" Update vim more often
filetype plugin indent on    																					" Customise vim based on filetypes, indents
set backspace=eol,start,indent																				" Configure backspace so it acts as expected.
set ignorecase																												" Ignore case when searching
set smartcase																													" Try to adapt to cases when searching
set hlsearch																													" Highlight search results.
set incsearch																													" Make the search act like in modern browsers
set lazyredraw																												" Don't redraw the screen when using macros, better performance.
set showmatch																													" Show matching brackets when cursor is over them
set mat=2																															" Flash on matching brackets TODO
set smarttab																													" Use spaces instead of tabs
set shiftwidth=2																											" The width used when >> is pressen
set tabstop=2																													" The width of a tab
set ai																																" Autoindent uses the same indent as the previous line
set si
set wrap																															" Line wrapping
set nostartofline																											" Don't automatically jump to the start of the line during some commands

packadd termdebug
let termdebugger = "startDebug.sh"

"map <C-D> :set splitright<CR> :90 vsplit gdb.txt<CR>:set autoread<CR>:au CursorHold * checktime<CR> :set norelativenumber<CR> <C-W>h :Termdebug<CR> <C-W>j <C-W>j :bd! a?<CR> <C-W>k b main <CR> c <CR> set logging redirect on<CR>set logging on<CR><C-w><C-r> <C-W>k :resize 55 <CR>
map <C-D> :Termdebug<CR> <C-W>j <C-W>j :bd! a?<CR> <C-W>k b main <CR> c <CR> <C-w><C-r> <C-W>k :resize 55 <CR>

execute "set <M-j>=\ej"
execute "set <M-l>=\el"
execute "set <M-r>=\er"
execute "set <M-f>=\ef"
execute "set <M-b>=\eb"
execute "set <M-c>=\ec"
execute "set <M-i>=\ei"
execute "set <M-s>=\es"
execute "set <M-x>=\ex"
noremap <M-j> :call TermDebugSendCommand('s')<CR>
noremap <M-l> :call TermDebugSendCommand('n')<CR>
noremap <M-r> :call TermDebugSendCommand('monitor reset halt')<CR> :call TermDebugSendCommand('c')<CR>
noremap <M-f> :call TermDebugSendCommand('monitor reset')<CR>:call TermDebugSendCommand('q')<CR> :call TermDebugSendCommand('y')<CR>
noremap <M-b> :Break<CR>
noremap <M-c> :Clear<CR>
noremap <M-s> :Continue<CR>
noremap <M-x> :Stop<CR>

set timeoutlen=1

""""""""" Clang Format
map <C-K> :pyf /home/stuart/bin/vim-clang-format.py<cr>

""""""""""	General Vim snippits

map <silent> <leader><Space> :noh<cr>																	" Disable highlight with leader key
nnoremap K gt																													" Use K to move to next tab
nnoremap J gT																													" Use J to more to previous tab
" move among buffers with CTRL
nnoremap L :bnext<CR>
nnoremap H :bprev<CR>

" Go to the file's last edited position when opening
autocmd BufReadPost *
						\ if line("'\"") > 0 && line("'\"") <= line("$") |
						\   exe "normal g`\"" |
						\ endif

" Delete trailing white space on save.
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.cpp :call DeleteTrailingWS()
autocmd BufWrite *.hpp :call DeleteTrailingWS()
autocmd BufWrite *.h 	:call DeleteTrailingWS()

" Visual selection custom function
vnoremap <silent> * :call VisualSelection('f', '')<CR>								" Search forward for word under cursor
vnoremap <silent> # :call VisualSelection('b', '')<CR>								" Search backwards for word under cursor
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Subfunction for VisualSelection
function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction

" Visual mode related function
function! VisualSelection(direction, extra_filter) range
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
			execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'gv'
			call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
	elseif a:direction == 'replace'
			call CmdLine("%s" . '/'. l:pattern . '/')
	elseif a:direction == 'f'
			execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

"auto close { brackets 'smartly'
function! s:CloseBracket()
    let line = getline('.')
    if line =~# '^\s*\(struct\|class\|enum\) '
        return "{\<Enter>};\<Esc>O"
    elseif searchpair('(', '', ')', 'bmn', '', line('.'))
        " Probably inside a function call. Close it off.
        return "{\<Enter>});\<Esc>O"
    else
        return "{\<Enter>}\<Esc>O"
    endif
endfunction
inoremap <expr> {<Enter> <SID>CloseBracket()

""""""""""	Plugin 'FZF' Settings

" RIPGREP preview window
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

""""""""""	Plugin 'Tagbar' Settings
nmap <F8> :TagbarToggle<CR>

"""""""""" 	Plugin 'You Complete Me' Settings
let g:ycm_confirm_extra_conf = 0
set hidden																														" Hide the preiview window buffer when exiting insert mode.
autocmd InsertLeave * if pumvisible() == 0|pclose|endif 							" Automatically cose the popup window when finished editing.

"""""""""" 	Plugin asyncrun settings
let g:asyncrun_status = "stopped"
augroup QuickfixStatus
	au! BufWinEnter quickfix setlocal 
		\ statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P
augroup END
:noremap <F9> :call asyncrun#quickfix_toggle(8)<cr>

let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

:command -nargs=* Make AsyncRun make 

autocmd User AsyncRunStart :copen
autocmd User AsyncRunStop :call ClosePreviewOnSuccess()

func! ClosePreviewOnSuccess()
	if g:asyncrun_code == 0
			:cclose
	endif
endfunc

""""""""""	Plugin 'Nerd Tree Tabs' Settings	
let g:nerdtree_tabs_open_on_console_startup=1

""""""""""	Latex Settings
function! TexFunction()

	let g:Tex_DefaultTargetFormat='pdf'																		" Build format for tex files
	let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf'	

	let g:livepreview_previewer = 'zathura'																" Preview used for autocompile
	autocmd Filetype tex setl updatetime=500															" How quickly to update the autocompile

	"Autocompile
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
	inoremap ;an \begin{align}<Enter><++> &= <++><Enter>\label{<++>}<Enter>\end{align}<Enter><++><Esc>gg/<++><Enter>"_c4l
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
	inoremap ;2t \begin{table}[H]<Enter>\centering<Enter>\begin{tabular}{l l}<Enter>\hline<Enter><++> & <++> \\<Enter>\hline<Enter><++> & <++> \\<Enter>\hline<Enter>\end{tabular}<Enter>\caption{<++>}<Enter>\label{tab:<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
	inoremap ;2n <Esc>o<++> & <++> \\<Esc>gg/<++><Enter>"_c4l
	inoremap ;3t \begin{table}[H]<Enter>\centering<Enter>\begin{tabular}{l l l}<Enter>\hline<Enter><++> & <++> & <++> \\<Enter>\hline<Enter><++> & <++> & <++> \\<Enter>\hline<Enter>\end{tabular}<Enter>\caption{<++>}<Enter>\label{tab:<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
	inoremap ;3n <Esc>o<++> & <++> & <++> \\<Esc>gg/<++><Enter>"_c4l
	inoremap ;4t \begin{table}[H]<Enter>\centering<Enter>\begin{tabular}{l l l l}<Enter>\hline<Enter><++> & <++> & <++> & <++> \\<Enter>\hline<Enter><++> & <++> & <++> & <++> \\<Enter>\hline<Enter>\end{tabular}<Enter>\caption{<++>}<Enter>\label{tab:<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
	inoremap ;4n <Esc>o<++> & <++> & <++> &<++> \\<Esc>gg/<++><Enter>"_c4l
	inoremap ;5t \begin{table}[H]<Enter>\centering<Enter>\begin{tabular}{l l l l l}<Enter>\hline<Enter><++> & <++> & <++> & <++> & <++> \\<Enter>\hline<Enter><++> & <++> & <++> & <++> & <++> \\<Enter>\hline<Enter>\end{tabular}<Enter>\caption{<++>}<Enter>\label{tab:<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
	inoremap ;5n <Esc>o<++> & <++> & <++> &<++> & <++> \\<Esc>gg/<++><Enter>"_c4l
	inoremap ;6t \begin{table}[H]<Enter>\centering<Enter>\begin{tabular}{l l l l l l}<Enter>\hline<Enter><++> & <++> & <++> & <++> & <++> & <++> \\<Enter>\hline<Enter><++> & <++> & <++> & <++> & <++> & <++> \\<Enter>\hline<Enter>\end{tabular}<Enter>\caption{<++>}<Enter>\label{tab:<++>}<Enter>\end{table}<Enter><++><Esc>gg/<++><Enter>"_c4l
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

endfunction

autocmd Filetype tex call TexFunction()																		" Call text function if the filetype is tex
