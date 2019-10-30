set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
"let g:ycm_server_python_interpreter = '/usr/bin/python'
"let g:ycm_server_python_interpreter = '/home/stuart/anaconda3/bin/python'
call vundle#begin()


Plugin 'LaTeX-Box-Team/LaTeX-Box'
"Plugin 'lervag/vimtex'
Plugin 'Valloric/YouCompleteMe'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'VOoM'
Plugin 'phongvcao/vim-stardict'
"Plugin 'SirVer/ultisnips'
"jPlugin 'honza/vim-snippets'
"Plugin 'sudar/vim-arduino-snippets'
"Plugin 'sudar/vim-arduino-syntax'
call vundle#end()            " required

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
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"

let vim_markdown_preview_github=1

let g:ycm_confirm_extra_conf = 0
