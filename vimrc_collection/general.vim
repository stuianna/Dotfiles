"Contains global commands used across all file types

"These are needed
set nocompatible
filetype plugin on
syntax on
colo desert

"Toggles line numbers or relative line numbers
"set number "absolute
set relativenumber "relative

"Double tap of space bar navigates to insert point denoted by <++>
inoremap <Space>` <Esc>/<++><Enter>"_c4l

"Open vim cheat sheet on <F5> press
map <F4> <Esc> :silent !ovcs <Enter> :redraw! <Enter>
inoremap <F4> <Esc> :silent !ovcs <Enter> :redraw! <Enter>

function! ToggleSpellCheck()
    set spell! spelllang=en_au
    if &spell
        echo "Spellcheck ON"
    else
        echo "Spellcheck OFF"
    endif
endfunction

"Spell check on/off
"map <F12> :set spell spelllang=en_au <Enter>
map <F12> :call ToggleSpellCheck()<Enter>
