local M = {}
local navic = require("nvim-navic")


-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  -- underline = true,
  -- virtual_text = true,
  -- signs = true,
  -- update_in_insert = true,
  local config = {
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua require('telescope.builtin').lsp_references({ show_line=false, trim_line=true, jump_type='never' })<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gic", "<cmd>lua require('telescope.builtin').lsp_incoming_calls({})<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>lua require('telescope.builtin').lsp_implementations({ show_line=false, trim_line=true })<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>da", "<cmd>lua require('telescope.builtin').diagnostics({ root_dir = vim.fn.expand('%:p:h') })<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-CR>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.diagnostic.open_float(0, {scope="line"})<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ async = false })' ]]
  vim.cmd [[ command! Format :call FFormat() ]]
end

local function disableFormatting(client)
  if vim.lsp.buf.format == nil then
    -- 老得两个都设置一下
    client.resolved_capabilities.document_formatting = false
    client.server_capabilities.documentFormattingProvider = false
  else
    client.server_capabilities.documentFormattingProvider = false
  end
end

local function diagnostic_auto_open_float()
  vim.api.nvim_exec(
    [[
    autocmd CursorHold * lua vim.diagnostic.open_float(0, {scope="cursor"})
  ]],
    false
  )
end


-- local lsp_status = require('lsp-status')
-- lsp_status.register_progress()
--
-- lsp_status.config({
--   indicator_info = '',
--   indicator_separator = '',
--   component_separator = '',
--   indicator_ok = '',
--
--   current_function = true,
--   show_filename = true,
--   diagnostics = false
-- })

function go_organize_imports_sync(timeoutms)
    local context = {source = {organizeImports = true}}
    vim.validate {context = {context, 't', true}}

    local params = vim.lsp.util.make_range_params()
    params.context = context

    local method = 'textDocument/codeAction'
    local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)

    -- imports is indexed with clientid so we cannot rely on index always is 1
    for _, v in next, resp, nil do
      local result = v.result
      if result and result[0] then
        local edit = result[0].edit
        vim.lsp.util.apply_workspace_edit(edit)
      end
    end
    -- Always do formating
    vim.lsp.buf.formatting()
end

M.on_attach = function(client, bufnr)
  -- if vim.version().minor >= 9 and client.name ~= "jdtls"  then
  if vim.version().minor >= 9 then
    -- semantic tokens highlight could override ts highlight
    client.server_capabilities.semanticTokensProvider = vim.NIL
  end

  if client.name == "volar" then
    disableFormatting(client)
  end
  if client.name == "tsserver" then
    disableFormatting(client)
  end
  if client.name == "jedi_language_server" then
    disableFormatting(client)
  end
  if client.name == "gopls" then
    disableFormatting(client)
    vim.cmd("autocmd BufWritePre <buffer> :call FFormat()")
    -- vim.cmd("autocmd BufWritePre <buffer> lua go_organize_imports_sync(1000)")
    -- vim.api.nvim_command("au BufWritePre *.go lua go_org_imports({}, 1000)")
    -- vim.cmd("autocmd BufWritePre go lua vim.lsp.buf.code_action({ source = { organizeImports = true } }")
  end

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  lsp_keymaps(bufnr)
  -- 下面这两个都非常影响性能，后面可以考虑去掉
  -- lsp_highlight_document(client)
  diagnostic_auto_open_float()
  -- lsp_status.on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = vim.tbl_deep_extend("force", lsp_status.capabilities, capabilities)

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)


return M
