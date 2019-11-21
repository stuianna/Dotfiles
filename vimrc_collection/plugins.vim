set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
"let g:ycm_server_python_interpreter = '/usr/bin/python'
"let g:ycm_server_python_interpreter = '/home/stuart/anaconda3/bin/python'
call vundle#begin()


Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'Valloric/YouCompleteMe'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-airline/vim-airline'
call vundle#end()   

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf'
let g:voom_python_versions = [3]

filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
set omnifunc=syntaxcomplete#Complete

let g:livepreview_previewer = 'zathura'
autocmd Filetype tex setl updatetime=500

let vim_markdown_preview_github=1

let g:ycm_confirm_extra_conf = 0

autocmd BufWinEnter * NERDTreeMirror
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists(“s:std_in”) | NERDTree | endif
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
set autoread

" copy to clipboard with Ctrl-C
 vmap <C-c> "+yi
 vmap <C-x> "+c
" paste from clipboard with Ctrl-V
 vmap <C-v> c<ESC>"+p
 imap <C-v> <C-r><C-o>+

 " buffer becomes hidden when abandoned
 set hidden

 " Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Enable use of the mouse for all modes
"set mouse=a
"
set smarttab
set shiftwidth=2
set tabstop=2
set ai
set si
set wrap

set nostartofline

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Search currnet file for matching word under cursor
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Disable highlight with leader key
map <silent> <leader><Space> :noh<cr>


" Go to last edditing file position
autocmd BufReadPost *
						\ if line("'\"") > 0 && line("'\"") <= line("$") |
						\   exe "normal g`\"" |
						\ endif

" Normally don't automatically format 'text' as it is typed, only do this
" with comments, at 79 characters.
au BufNewFile,BufEnter *.c,*.h,*.java,*.jsp set formatoptions-=t tw=79

" Delete trailing white space on save, useful for Python and CoffeeScript
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

" Enable true colors support
set t_Co=256


" -----------------------------------------------------------
" YCM AUTOCOMPLETION
" -----------------------------------------------------------
"Close popup menu upon leaving insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif 

" -----------------------------------------------------------
" SNIPPET_RELATED
" -----------------------------------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-e>"
" location where snippets are saved
"let g:UltiSnipsSnippetDirectories=["plugged/vim-snippets/UltiSnips"]

" function to differentiate usage of tab under ultisnip/ycm
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" Expand snippet or return
let g:ulti_expand_res = 1
function! Ulti_ExpandOrEnter()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res
        return ''
    else
        return "\<return>"
endfunction
" Set <space> as primary trigger
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>



"-------------------------------------------------------------
" AIRLINE
" ------------------------------------------------------------

" enable powerline fonts
let g:airline_powerline_fonts = 1
" enable tabline
let g:airline#extensions#tabline#enabled = 1
" show tab number in tabline
let g:airline#extensions#tabline#tab_nr_type = 1
" make the filename in buffer shorter, not the full path
let g:airline#extensions#tabline#fnamemod=':t'
" show buffer number in tabline
" let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#vimtex#left = ""
let g:airline#extensions#vimtex#right = ""

"  airline symbols dictionary
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"" unicode symbols, for multiple definitions choose one
""let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
""let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
""let g:airline_symbols.linenr = '☰'
""let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
""let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = ''
""let g:airline_symbols.maxlinenr = '㏑'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
""let g:airline_symbols.paste = 'Þ'
""let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
"let g:airline_symbols.notexists = 'Ɇ'
"let g:airline_symbols.whitespace = 'Ξ'
