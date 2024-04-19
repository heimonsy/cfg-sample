local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local navic = require("nvim-navic")

local show_in_width = function()
	return vim.fn.winwidth(0) > 120
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = show_in_width
}


local mode = {
	"mode",
  padding = 1,
}

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 1,
  icons_enabled = true,
  icon = "",
}

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local spaces = function()
  if vim.api.nvim_buf_get_option(0, "expandtab") then
    return "sp:" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  else
    return "tab:" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end
end

local packagwithtag = {
  "packagwithtag",
  icons_enabled = false, -- Enables the display of icons alongside the component.
  padding = 1,
  fmt = function ()
    local tag = navic.get_location()

    if not show_in_width() then
      return ""
    end

    -- print("WTF", tag, vim.fn.PackageName())
    if tag == '' then
      return vim.fn.PackageName()
    end
    return vim.fn.PackageName() .. '  ' .. tag
  end,
  -- cond = show_in_width,
}

local fileinfo = {
  "fileinfo",
  icons_enabled = false,
  padding = 1,
  fmt = function ()
    local format = vim.bo.fileformat
    return format .. ':' .. vim.opt.fileencoding:get()
  end,
}

-- copied from papercolor_light
local colors = {
  red                    = '#df0000',
  green                  = '#008700',
  blue                   = '#4271ae',
  pink                   = '#d7005f',
  olive                  = '#718c00',
  navy                   = '#005f87',
  orange                 = '#d75f00',
  purple                 = '#8959a8',
  aqua                   = '#3e999f',
  foreground             = '#4d4d4c',
  background             = '#F5F5F5',
  window                 = '#efefef',
  status                 =  '#3e999f',
  error                  = '#ffafdf',
  statusline_active_fg   =  '#efefef',
  statusline_active_bg   =  '#005f87',
  statusline_inactive_fg =  '#4d4d4c',
  statusline_inactive_bg = '#dadada',
}



lualine.setup({
	options = {
		icons_enabled = true,
		theme = {
      normal = {
        a = { fg = colors.foreground, bg = colors.background, gui = 'bold' },
        b = { fg = colors.statusline_active_fg, bg = colors.status },
        c = { fg = colors.statusline_active_fg, bg = colors.statusline_active_bg },
      },
      insert = { a = { fg = colors.blue, bg = colors.background, gui = 'bold' } },
      visual = { a = { fg = colors.background, bg = colors.orange, gui = 'bold' } },
      replace = { a = { fg = colors.background, bg = colors.pink, gui = 'bold' } },
      inactive = {
        a = { fg = colors.foreground, bg = colors.background, gui = 'bold' },
        b = { fg = colors.foreground, bg = colors.background },
        c = { fg = colors.foreground, bg = colors.statusline_inactive_bg },
      },
  },
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch },
		lualine_c = { "filename", packagwithtag},
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diagnostics, diff},
		lualine_y = {  spaces, "encoding", {"fileformat", icons_enabled=false}, filetype },
		lualine_z = { location, progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
