-- In command line, the JAVA_HOME is set to /opt/homebrew/opt/openjdk@11
-- But I need openjdk@17 for jdtls and java development
-- if vim.fn.has('macunix') == 1 then
--   vim.fn.setenv("JAVA_HOME", "/opt/homebrew/opt/openjdk@17" )
-- end

-- example:
-- https://github.com/lucario387/nvim/blob/main/ftplugin/java.lua#L25

if #vim.api.nvim_list_uis() == 0 then
  return
end

local home = os.getenv("HOME")

local handlers = require('user.lsp.handlers')

local config = {
  cmd = {
    home .. "/.local/share/nvim/mason/bin/jdtls",
    "--jvm-arg=-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
  },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
}

require('jdtls').start_or_attach(config)

-- local lsp_config = require("lspconfig.server_configurations.jdtls").default_config
--
-- local filetypes = lsp_config.filetypes
--
-- vim.api.nvim_create_autocmd("FileType", {
--   group = vim.api.nvim_create_augroup("MyJdtls", { clear = true }),
--   pattern = filetypes,
--   callback = function()
--     init_jdtls()
--   end,
-- })
--
-- return
