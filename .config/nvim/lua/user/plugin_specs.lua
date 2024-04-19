local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugin_specs = {
  { "NLKNguyen/papercolor-theme", lazy = true },
  { "nvim-lua/plenary.nvim" },
  { "farmergreg/vim-lastplace" },
  {
    "github/copilot.vim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    cmd = "Copilot",
    config = function()
      require("user.plugin_config.copilot")
    end,
  },


  -- auto-completion engine
  {
    "hrsh7th/nvim-cmp",
    -- event = 'InsertEnter',
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",                   -- buffer completions
      "hrsh7th/cmp-path",                     -- path completions
      "hrsh7th/cmp-cmdline",                  -- cmdline completions
      "saadparwaiz1/cmp_luasnip",             -- snippet completions
      -- "onsails/lspkind-nvim",
      {
        "windwp/nvim-autopairs",
        config = function ()
          require("user.plugin_config.autopairs")
        end,
      },
      {
        "L3MON4D3/LuaSnip",
        config = function()
          -- Other Config example: https://github.com/lucario387/nvim/blob/main/lua/plugins.lua#L192
          require("luasnip.loaders.from_snipmate").lazy_load()
        end,
      },
    },
    config = function()
      require("user.plugin_config.cmp")
    end,
  },

  -- Easily comment stuff
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre" },
    config = function()
      require("user.plugin_config.comment")
    end,
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = { "BufReadPre" },
        config = function()
          vim.g.skip_ts_context_commentstring_module = true
          require('ts_context_commentstring').setup{
            enable_autocmd = false,
          }
        end,
      },
    }
  },

  { "nvim-tree/nvim-web-devicons" },
  -- tree plugin
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    config = function()
      require("user.plugin_config.nvim-tree")
    end,
  },

  -- Bdelete and Bwipeout
  { "moll/vim-bbye" },

  { "SmiteshP/nvim-navic" },

  {
    "akinsho/bufferline.nvim",
    event = { "BufEnter" },
    config = function()
      require("user.plugin_config.bufferline")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("user.plugin_config.lualine")
    end,
  },

  { "akinsho/toggleterm.nvim", version = "*", config = true },

  {
    "neovim/nvim-lspconfig",
    branch = "master",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- "folke/lsp-colors.nvim",
    },
    config = function(_, opts)
      require("user.lsp")
    end,
  },

  { "williamboman/mason.nvim", cmd = "Mason" },

  { "mfussenegger/nvim-jdtls", lazy = true },


  -- TODO: use nvimtools/none-ls.nvim
  { "jose-elias-alvarez/null-ls.nvim", lazy = true },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    event = { "CmdlineEnter" },
    config = function()
      require("user.plugin_config.telescope")
    end,

    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    build = ":TSUpdate",
    config = function()
      require("user.plugin_config.treesitter")
    end,
  },

  -- show code context
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    enabled = true,
    opts = { mode = "cursor", max_lines = 3 },
  },

  {
    "nvim-treesitter/playground",
    event = "VeryLazy",
  },

  {
    'liuchengxu/vista.vim',
    event = "VeryLazy",
    cmd = "Vista"
  },

  {
    "airblade/vim-rooter",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("user.plugin_config.gitsigns")
    end,
  },

  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    cmd = "Git",
  },
}

-- configuration for lazy itself.
local lazy_opts = {
  install = {
    colorscheme = { "PaperColor" },
  },
  ui = {
    border = "rounded",
    title = "Plugin Manager",
    title_pos = "center",
  },
}

require("lazy").setup(plugin_specs, lazy_opts)
