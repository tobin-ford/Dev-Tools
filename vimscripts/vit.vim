" ~/.vim/vit.vim
" set shell=/bin/sh

" tall terminal on left, small terminals on right
"+----------------+----------------+
"|                |                |
"|                |                |
"|                |                |
"|                +----------------+
"|                |                |
"|                |                |
"|                |                |
"+----------------+----------------+

call timer_start(100, { -> execute('terminal') })

vsplit
terminal

wincmd l

terminal

wincmd j
bdelete!
