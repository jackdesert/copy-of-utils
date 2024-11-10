set clipboard+=unnamedplus
"syntax on
"autocmd FileType markdown setlocal syntax=on
"
" You must specify a colorscheme; else you will not see any color
colorscheme desert



" Make comments darker in zig files (Daniel)
augroup ZigComments
    autocmd!
    autocmd FileType zig highlight Comment ctermfg=240 guifg=#505050
    " If you're using treesitter, also add this line:
    autocmd FileType zig highlight @comment ctermfg=240 guifg=#505050
augroup END


"Make case INsensitive by default,
"but if you add any capital letters, it switches to case sensitive
set ignorecase smartcase

