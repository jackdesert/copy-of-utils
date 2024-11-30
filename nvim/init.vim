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

" Save file with either semicolon or colon
nnoremap ; :


" On macOS, tell neovim where the python executable is located
"   This is to avoid the 22 second load time of python files
"   (This avoids the ugly hack of needing to `pip install neovim`)
"
"   First check if the path we are providing actually exists
let s:pyenv_python = '/Users/jd/.pyenv/shims/python3'
if filereadable(s:pyenv_python)
    "   If it exists, we set this variable
    let g:python3_host_prog = s:pyenv_python
endif


" Use tabs instead of spaces for python files
" (This is to support archinstall)
"autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
