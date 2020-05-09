let g:pymode_python = 'python3'
""""""""""	Plugins

call plug#begin('~/.vim/plugger')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'LaTeX-Box-Team/LaTeX-Box'																			" For latex compile
Plug 'xuhdev/vim-latex-live-preview'																" For latex live preview
Plug 'scrooloose/nerdtree'																					" Vim file browser
Plug 'jistr/vim-nerdtree-tabs'																			" Better tab handling for nerd-tree
Plug 'Xuyuanp/nerdtree-git-plugin'																	" Show git status in nerdtree
Plug 'vim-airline/vim-airline'																			" Status line and tag line
Plug 'ryanoasis/vim-webdevicons'																		" Icons for vim
Plug 'scrooloose/nerdcommenter'																			" Commenting plugin
Plug 'majutsushi/tagbar'																						" Tagbar
Plug 'tpope/vim-fugitive'																						" Git wrapper for git inside of vim
Plug 'airblade/vim-gitgutter'																				" Show git status in numbers line
Plug 'ludovicchabant/vim-gutentags'																	" Use tags to zip through source files.
Plug 'junegunn/fzf'																									" Fuzzy search plugin
Plug 'junegunn/fzf.vim'
Plug 'skywind3000/asyncrun.vim'																			" Background task handling
"Plug 'vim-syntastic/syntastic'																			" Background task handling
Plug 'dense-analysis/ale' 																					" Linting 
Plug 'michaeljsmith/vim-indent-object'														  " Indent text object selection
Plug 'tpope/vim-surround'														  							" Suround text editing
Plug 'tpope/vim-repeat'														  								" Repeat plugin based command
Plug 'Konfekt/vim-alias'														  							" Command line vim aliases
"Plug 'Vimjas/vim-python-pep8-indent'														 		" Python indentation compliant with PEP8

Plug 'iamcco/markdown-preview.nvim',  { 'do': { -> mkdp#util#install() } }
call plug#end()   

set encoding=utf8



""""""""""	General Vim Settings	
set number
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
set expandtab
set tabstop=2																													" The width of a tab
set ai																																" Autoindent uses the same indent as the previous line
set si
set wrap																															" Line wrapping
set nostartofline																											" Don't automatically jump to the start of the line during some commands
highligh clear SignColumn

" Fix sign priorities
let g:gitgutter_sign_priority =  8


""""""""" COC
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""""""""" Clang Format
map <C-K> :py3f /home/stuart/.bin/clang-format.py<cr>

""""""""" Format json files
map <C-J> :%!python -m json.tool <CR>

""""""""" ALE
let g:ale_linters = {
  \ 'python': ['flake8']
  \}

let g:ale_fixers = {
  \ 'python': ['yapf'],
  \ 'cpp': ['clang-format'],
  \ 'c': ['clang-format'],
  \}

nmap <F10> :ALEFix<CR>

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

""""""""""	Vim Debug Settings

packadd termdebug
let termdebugger = "startDebug.sh"

function! ToggleDebugMode()
	if !exists('b:debug')
		let b:debug=1
		noremap <Space>j :call TermDebugSendCommand('s')<CR> 
		noremap <Space>f :call TermDebugSendCommand('monitor reset')<CR>:call TermDebugSendCommand('q')<CR> :call TermDebugSendCommand('y')<CR> :noremap K gt <CR> :cal ToggleDebugMode()<CR>
		noremap <Space>l :call TermDebugSendCommand('n')<CR>
		noremap <Space>r :call TermDebugSendCommand('monitor reset halt')<CR> :call TermDebugSendCommand('c')<CR>
		noremap <Space>b :Break<CR>
		noremap <Space>c :Clear<CR>
		noremap <Space>s :Continue<CR>
		noremap <Space>x :Stop<CR>
	else
		unlet b:debug
		noumap <Space>j
		noumap <Space>f
		noumap <Space>l
		noumap <Space>r
		noumap <Space>b
		noumap <Space>c
		noumap <Space>s
		noumap <Space>x
	endif
	return ""
endfunction


map <C-D> :Termdebug<CR> <C-W>j <C-W>j :bd! a?<CR> <C-W>k b main <CR> c <CR> <C-w><C-r> <C-W>k :resize 55 <CR> :call ToggleDebugMode() <CR>

""""""""""	Plugin 'Markdown Preview' Settings
let g:mkdp_browser = 'brave'


""""""""""	Plugin 'Vim - Syntastic' Settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
""let g:syntastic_loc_list_height = 5
"let g:syntastic_enable_highlighting=1
"let g:syntastic_cpp_checkers = ['clang_tidy']
"let g:syntastic_cpp_clang_tidy_post_args = ""

""""""""""	Plugin 'FZF' Settings

" RIPGREP preview window
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


nnoremap <C-F> :Files <CR>

""""""""""	Plugin 'Gutentag' Settings
let g:gutentags_exclude_project_root = ['usr/local','/home/stuart','/home/stuart/Dotfiles']
let g:gutentags_ctags_extra_args = ['--fields=+l']

""""""""""	Plugin 'Tagbar' Settings
nmap <F8> :TagbarToggle<CR>

""""""""""	Plugin 'Airline' Settings
let g:airline_powerline_fonts = 1

"""""""""" 	Plugin 'You Complete Me' Settings
"let g:ycm_confirm_extra_conf = 0
" Below was enabled
"let g:ycm_enable_diagnostic_highlighting = 0
"let g:ycm_show_diagnostics_ui = 1
"let g:ycm_always_populate_location_list = 1
"let g:ycm_enable_diagnostic_signs = 1
"let g:ycm_use_clangd=1
"let g:ycm_auto_trigger = 1
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_global_ycm_extra_conf = "/home/stuart/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py"
"set hidden																														" Hide the preiview window buffer when exiting insert mode.
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif 							" Automatically cose the popup window when finished editing.

"""""""""" 	Plugin asyncrun settings
let g:asyncrun_status = "stopped"
augroup QuickfixStatus
	au! BufWinEnter quickfix setlocal 
		\ statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P
augroup END
:noremap <F9> :call asyncrun#quickfix_toggle(8)<cr>

let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

cnoreabbrev ; AsyncRun

":command -nargs=* Make AsyncRun make *

"autocmd User AsyncRunStart :copen
autocmd User AsyncRunStop :call ClosePreviewOnSuccess()


func! ClosePreviewOnSuccess()
	if g:asyncrun_code != 0
			:copen
	endif
endfunc

""""""""""	Plugin 'Nerd Tree Tabs' Settings	
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"let g:nerdtree_tabs_open_on_console_startup=1
"nmap <silent> <F7> :if nerd_tree_enable == 1 \| NERDTreeToggle \| let nerd_tree_enable=0 \| else \| NERDTreeToggle \| let nerd_tree_enable=1 \| endif <CR>
nmap <F7> :NERDTreeTabsToggle <CR>

let g:livepreview_previewer = 'zathura'																" Preview used for autocompile
""""""""""	Latex Settings
function! TexFunction()

	let g:Tex_DefaultTargetFormat='pdf'																		" Build format for tex files
	let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf'	

	autocmd Filetype tex setl updatetime=500															" How quickly to update the autocompile

  inoremap <Space>` <Esc>gg/<++><Enter>"_c4l

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
