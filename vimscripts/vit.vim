" ~/.vim/vit.vim
" set shell=/bin/sh

call timer_start(100, { -> execute('terminal') })

vsplit
terminal

wincmd l

terminal

wincmd j
bdelete!
