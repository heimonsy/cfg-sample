-- seems useless
vim.cmd([[autocmd FocusLost * :silent! wall]])


-- update file when regaining focus (Ctrl-z then fg)
vim.cmd([[au WinEnter,TabEnter,FocusGained,BufEnter,UIEnter * :checktime]])

-- 进入命令模式时忽略大小写，这样按 tab 就能方便自动不全
vim.cmd([[
    augroup dynamic_smartcase
    autocmd!
    autocmd CmdlineEnter : set ignorecase
    autocmd CmdlineLeave : set smartcase
    augroup END
]])

-- relative number toggle
vim.cmd([[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]])


vim.cmd([[
    " automatically remove the target/dependency files when the pom.xml is changed
    autocmd BufWritePost pom.xml silent !mvn clean
    " automatically remove the build files when the build.gradle is changed
    autocmd BufWritePost build.gradle silent !gradle clean
    autocmd BufWritePost build.gradle.kt silent !gradle clean

    autocmd FileType lua setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType markdown setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType java setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
    " autocmd FileType c setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType cpp setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType typescript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType javascript.jsx setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType html setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType vue setlocal expandtab shiftwidth=2 expandtab tabstop=2 softtabstop=2
    autocmd FileType xml setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType proto setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
  " proto 的 smartindent 有 bug
    autocmd FileType proto setlocal nosmartindent


    " highlight ExtraWhitespace ctermbg=red guibg=red
    " match ExtraWhitespace /\s\+$/
]])
