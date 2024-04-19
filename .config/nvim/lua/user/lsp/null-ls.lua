local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local function find_root_dir(start_dir, targets)
    local dir = start_dir
    while dir ~= '/' do
        for _, target in ipairs(targets) do
            local path = dir .. '/' .. target
            local stat = vim.loop.fs_stat(path)
            if stat then
                return dir
            end
        end
        dir = vim.fn.fnamemodify(dir, ':h')
    end
    return nil
end

-- see if the file exists
function FileExists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local root_dir = find_root_dir(vim.fn.getcwd(), {".git", "go.mod"})

-- Get the value of the module name from go.mod in PWD
function GetGoModuleName()
  if not root_dir then return nil end

  local goModPath = root_dir .. '/go.mod'

  if not FileExists(goModPath) then return nil end

  for line in io.lines(goModPath) do
    if vim.startswith(line, "module") then
      local items = vim.split(line, " ")
      local module_name = vim.trim(items[2])
      return module_name
    end
  end
  return nil
end

local goModule = GetGoModuleName()

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }),
		formatting.black.with({ extra_args = { "--fast" } }),
    -- formatting.stylua,
    formatting.pyink,
    -- formatting.clang_format,
    formatting.goimports.with({ extra_args = { "-local", goModule}}),
    -- formatting.goimports.with({ extra_args = { "-local", goModule}}),
    -- diagnostics.flake8
    diagnostics.golangci_lint,
	},
})
