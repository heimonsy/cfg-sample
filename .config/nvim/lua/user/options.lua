-- default enabled by neovim, full list: https://neovim.io/doc/user/vim_diff.html#nvim-defaults
-- vim.opt.autoindent = true
-- vim.opt.filetype = 'on'
-- vim.opt.syntax = 'on'
-- vim.opt.autoread = true
-- vim.opt.backspace = "indent,eol,start"
-- vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern


vim.opt.backup = true                           -- creates a backup file
vim.opt.backupdir = vim.fn.stdpath("data") .. "/cache/backup"
vim.opt.undodir = vim.fn.stdpath("data") .. "/cache/undo"
vim.opt.history = 10000
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.magic = true                           -- set magic on, for regular expressions
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"
-- override by wildmenu
-- vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.autochdir = false
vim.opt.smartcase = true                        -- smart case
-- 这里必须为 true 才能使当前 number 显示不同颜色
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.virtualedit = "onemore"
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.number = true                           -- set numbered lines
vim.opt.guicursor = ""
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.tabstop = 4                             -- insert 2 spaces for a tab
vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
vim.opt.softtabstop = 4
vim.opt.numberwidth = 4                         -- set number column width to 4 {default 4}
vim.opt.list = true
vim.opt.colorcolumn = "120"
-- vim.opt.listchars.extends = "#"
-- vim.opt.listchars.tab = ">"
-- vim.opt.listchars.trail = "+"
vim.opt.listchars = { tab = "> ", trail = "·", nbsp = "+" }
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = ""
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications

vim.opt.shortmess:append("c")

-- vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.opt.whichwrap:append("<,>,[,],h,l")

-- vim.cmd [[set iskeyword+=-]]
-- vim.opt.iskeyword:append("-")

-- vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
-- the following doesn't work either, I guess it is controlled by Comment.nvim
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- " 水平分割线的占位符
vim.opt.fillchars:append({vert="▕"})


vim.lsp.set_log_level = 'trace'


vim.cmd([[
    " set fillchars+=vert:\▕
    " function! Timer()
    "   checktime
    "   call feedkeys("f\e")
    " endfunction

    " 自动切换到文件所在目录
    " autocmd BufEnter * silent! lcd %:p:h

  " 光标记忆
    " autocmd BufRead * autocmd FileType <buffer> ++once
      " \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"zz' | endif

  " 光标记忆
    " augroup JumpCursorOnEdit
    "     au!
    "     autocmd BufReadPost *
    "       \ if expand("<afile>:p:h") !=? $TEMP |
    "       \   if line("'\"") > 1 && line("'\"") <= line("$") |
    "       \     let JumpCursorOnEdit_foo = line("'\"") |
    "       \     let b:doopenfold = 1 |
    "       \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
    "       \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
    "       \        let b:doopenfold = 2 |
    "       \     endif |
    "       \     exe JumpCursorOnEdit_foo |
    "       \   endif |
    "       \ endif
    "     " Need to postpone using "zv" until after reading the modelines.
    "     autocmd BufWinEnter *
    "       \ if exists("b:doopenfold") |
    "       \   exe "normal zv" |
    "       \   if(b:doopenfold > 1) |
    "       \       exe  "+".1 |
    "       \   endif |
    "       \   unlet b:doopenfold |
    "       \ endif
    " augroup END

    " 临时用来显示 sjis（Shift-JIS）日文编码的文件
    set fileencodings=ucs-bom,utf-8,sjis,default
]])

