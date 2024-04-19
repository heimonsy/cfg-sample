local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {
    "c", "cpp","java","vue", "lua", "go", "html", "css",
    "typescript", "javascript", "rust", "python", "bash", "kotlin",
    "markdown", "vimdoc"
  }, -- one of "all", "maintained" (parsers with maintainers, deprecated), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "perl", "gitcommit"}, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "fish", "proto" , "go", "cpp"} },
  -- context_commentstring = {
  --   enable = true,
  --   enable_autocmd = false,
  -- },
}

