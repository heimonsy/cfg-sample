local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end


local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

local jsonls_opts = require("user.lsp.settings.jsonls")
lspconfig.jsonls.setup(vim.tbl_deep_extend("force", jsonls_opts, opts))


local sumneko_opts = require("user.lsp.settings.sumneko_lua")
lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", sumneko_opts, opts))


local jdtls_opts = vim.tbl_deep_extend("force", {
    vmargs = {
      "-XX:+UseParallelGC",
      "-XX:GCTimeRatio=4",
      "-XX:AdaptiveSizePolicyWeight=90",
      "-Dsun.zip.disableMemoryMapping=true",
      "-Djava.import.generatesMetadataFilesAtProjectRoot=false",
      "-Xmx8G",
      "-Xms100m",
    },
    use_lombok_agent = true,
    workspace = "/tmp/jdtls/workspace"
}, opts)
lspconfig.jdtls.setup(jdtls_opts)

local gopls_opts = vim.tbl_deep_extend("force", {
  cmd = {"gopls", "-remote=auto"},
}, opts)

lspconfig.gopls.setup(gopls_opts)

lspconfig.jedi_language_server.setup(opts)

-- lspconfig.rust_analyzer.setup({
--   imports = {
--     group = {
--       enable = false,
--     },
--     granularity = {
--       group = "module",
--     },
--     prefix = "self",
--   }
-- })
