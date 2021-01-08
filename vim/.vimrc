syntax on
colorscheme torte 

set visualbell
set encoding=utf-8
set fileencoding=utf-8
set nowrap
set number

autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4

filetype plugin indent on
set backspace=indent,eol,start

" VIM-GO CONFIGS
" Syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" Enable auto formatting on saving
let g:go_fmt_autosave = 1
" Run `goimports` on your current file on every save
let g:go_fmt_command = "goimports"
" Status line types/signatures
let g:go_auto_type_info = 1

" Paredit config for Janet
au FileType janet call PareditInitBuffer()

" NERDTree config
nnoremap <C-g> :NERDTreeToggle<CR>

autocmd VimEnter * GoInstallBinaries
