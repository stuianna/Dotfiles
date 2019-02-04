"Controls and calls all other vimrc configuration files.

"Created - 13/10/17
"Modified - 13/10/17

"Load all plugins
:source ~/.vimrc_collection/plugins.vim

"Load global commands

:source ~/.vimrc_collection/general.vim

"Load Latex related comfiguration

autocmd FileType tex :source ~/.vimrc_collection/latex.vim

"change tab character to 4 spaces
:set softtabstop=4 tabstop=4 shiftwidth=4 expandtab
