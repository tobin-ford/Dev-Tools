filetype on
set relativenumber

""""""""""""""""""""""""""""""""""""""
" Color Schemes
syntax on
set background=dark
set termguicolors
set t_Co=256

" github.com/sainnhe/gruvbox-material
colorscheme gruvbox

" github.com/morhetz/gruvbox/releases
" colorscheme gruvbox_material

""""""""""""""""""""""""""""""""""""""

" set to block cursor when we open the file
autocmd VimEnter * silent !echo -ne "\e[2 q"

" Change cursor shape based on mode
if has('termguicolors')
    let &t_SI = "\e[6 q"     " Set cursor to line in insert mode
    let &t_EI = "\e[2 q"     " Reset cursor to block in normal mode
    let &t_SR = "\e[4 q"     " Set cursor to underline in replace mode
endif
