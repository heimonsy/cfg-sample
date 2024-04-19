local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

local function nextItem(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expandable() then
    luasnip.expand()
  -- elseif luasnip.expand_or_jumpable() then
    -- luasnip.expand_or_jump()
  elseif check_backspace() then
    fallback()
  else
    fallback()
  end
end

local function prevItem(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

cmp.setup {
  snippet = {
    expand = function(args)
      -- print(vim.inspect(args.body))
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    -- ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
    ["<C-e>"] = cmp.mapping(function(fallback)
      if luasnip.expandable() then
        luasnip.expand()
        return
      end

      local confirm_opts =  { behavior = cmp.ConfirmBehavior.Insert, select = true }
      if cmp.confirm(confirm_opts) then
        return -- success, exit early
      end
      fallback()
    end),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    -- ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<CR>"] = cmp.mapping(function(fallback)
      -- workaround for https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/issues/13
      -- 只显示函数签名时不补全, 而是换行
      local entries = cmp.get_entries()
      if (not cmp.visible()) or (#entries == 1 and entries[1].source.name == 'nvim_lsp_signature_help') then
        fallback()
      else
        if cmp.visible() then
          local confirm_opts =  { behavior = cmp.ConfirmBehavior.Replace, select = false }
          local is_insert_mode = function()
            return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
          end
          if is_insert_mode() then
            confirm_opts.behavior = cmp.ConfirmBehavior.Replace
          end
          if cmp.confirm(confirm_opts) then
            return -- success, exit early
          end
        end
        fallback()
      end
    end),
    -- ["<Tab>"] = cmp.mapping(nextItem, {"i", "s"}),
    -- ["<S-Tab>"] = cmp.mapping(prevItem, {"i", "s"}),
    ["<C-n>"] = cmp.mapping(nextItem, {"i", "s"}),
    ["<C-p>"] = cmp.mapping(prevItem, {"i", "s"}),
  },
  completion = {
        completeopt = 'menu,menuone,noinsert',
        auto_select = true,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    -- { name = "copilot"},
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = 'nvim_lsp_signature_help' },
    { name = "buffer" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    -- automatically select first item
    select = false,
  },
  preselect = cmp.PreselectMode.Item,
  sorting = {
    priority_weight = 5,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.length,
      cmp.config.compare.sort_text,
      cmp.config.compare.order,
    },
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}
