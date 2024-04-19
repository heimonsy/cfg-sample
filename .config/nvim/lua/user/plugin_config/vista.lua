vim.cmd [[

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

let g:vista_default_executive = 'ctags'

let g:vista_executive_for = {
  \ 'go': 'nvim_lsp'
  \ }

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\   "field": "\uf911",
\   "fields": "\uf911",
\   "method": "\uf794",
\   "methods": "\uf794",
\   "classes": "\uf0e8",
\  }

" function! NearestMethodOrFunction() abort
  " return get(b:, 'vista_nearest_method_or_function', '')
" endfunction

" set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

]]
