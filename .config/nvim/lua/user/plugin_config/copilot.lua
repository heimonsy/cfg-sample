vim.cmd([[
    imap <silent><script><expr> <C-;> copilot#Accept("\<CR>")
    imap <silent><script><expr> <C-]> copilot#Next()
    imap <silent><script><expr> <C-[> copilot#Previous()
    " let g:copilot_no_tab_map = v:true
    " let g:copilot_proxy = 'localhost:8118'
    let g:copilot_filetypes = {
      \ '*': v:true,
      \ }
]])

