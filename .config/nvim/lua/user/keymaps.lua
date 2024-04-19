local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap , as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

keymap("n", ";", ":", { noremap = true})
keymap("n", "0", "^", { noremap = true})

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
keymap("n", "<leader>v", ":e ~/.config/nvim/init.lua<cr>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>def", ":SearchDef<CR>", opts)
keymap("n", "<leader>ref", ":SearchRef<CR>", opts)
keymap("n", "<leader>rs", ":LspRestart<CR>", opts)
-- search in current file directory
keymap("n", "<leader>w", "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:p:h') })<CR>", opts)
keymap("n", "<leader>bt", ":Vista!!<cr>", opts)

keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "Y", "y$", opts)
keymap("n", "<C-p>", ":PFiles<CR>", opts)
keymap("n", "<C-n>", ":Telescope grep_string<CR>", opts)
keymap("n", "<C-g>", ":call NormalNextFnArg()<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<C-q>", ":bd!<CR>", opts)
keymap("n", "<C-c>", ":call CtrlC()<CR>", opts)
keymap("n", "<leader>co", ":call CloseOtherBuffers()<CR>", opts)

-- Nvimtree
keymap("n", "<leader>n", ":NvimTreeToggle<CR>", opts)

-- forward and backward with centering
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- custom
keymap("n", "<leader>tf", ":call FunctionTest()<CR>", {})
keymap("n", "<leader>ta", ":call FunctionTestAll()<CR>", {})
-- keymap("n", "<leader>gr", ":call JR()<cr>", opts)
keymap("n", "<leader>gb", ":call MyBuild()<cr>", opts)
keymap("n", "<leader>bd", ":call MyBuild()<cr>", opts)
keymap("n", "<leader>jr", ":call JR()<cr>", opts)
keymap("n", "<leader>ff", ":call FFormat()<cr>", opts)
keymap("n", "<leader>cfd", ":echo expand('%:p')<cr>", opts)

-- keymap("n", "<leader>;", "getline('.')[-1:] == ';' ? '' : 'A;<Esc>'", opts)


function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

vim.keymap.set( "v", "<leader>fg", function()
	local text = string.gsub(vim.getVisualSelection(),"[(]", "\\(")
  require('telescope.builtin').live_grep({ default_text = text })
end, opts)



-- other usefull

-- delete current selected and paste the copied
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>p", "\"_dwP")



-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "*", ":call VisualSearch('f')<CR>", {noremap = true, silent = true})

-- Paste over visual selection
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


--  Comment
keymap("n", "<leader>cc", "gcc", {})
keymap("n", "<leader>cu", "gcc", {})
keymap("v", "<leader>cc", "gc", {})
keymap("v", "<leader>cu", "gc", {})

-- move in insert mode
-- inoremap <C-j> <C-o>gj
-- inoremap <C-k> <C-o>gk
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-l>", "<Right>", opts)

keymap("c", "<C-B>", "<S-Left>", opts)
keymap("c", "<C-F>", "<S-Right>", opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", opts)
keymap("n", "<Up>", ":resize -1<CR>", opts)
keymap("n", "<Down>", ":resize +1<CR>", opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)



vim.cmd([[
  " insert semicolon/comma at the end of the line
  inoremap <expr> ;<cr> getline('.')[-1:] == ';' ? '<Esc>' : '<End>;<Esc>'
  nnoremap <expr> <leader>; getline('.')[-1:] == ';' ? '' : 'A;<Esc>'
  nnoremap <expr> <leader>, getline('.')[-1:] == ',' ? '' : 'A,<Esc>'
]])
