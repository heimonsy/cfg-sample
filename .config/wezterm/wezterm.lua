local wezterm = require 'wezterm'

local my_default_prog = {"/usr/bin/fish", "-l"}

-- if it is macOS, use /opt/homebrew/bin/fish
if string.find(wezterm.target_triple, "apple") or string.find(wezterm.target_triple, "darwin") then
  my_default_prog = {"/opt/homebrew/bin/fish", "-l"}
end

return {
  default_prog = my_default_prog,

  window_padding = {
    left = 2, right = 2,
    top = 0, bottom = 0,
  },
  window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    -- font = wezterm.font({family="Roboto", weight="Bold"}),

    -- The size of the font in the tab bar.
    -- Default to 10. on Windows but 12.0 on other systems
    font_size = 11.0,
  },

  font_size = 13,
  line_height = 1.0,
  font = wezterm.font_with_fallback({
      -- disable ligatures for Monaco as it has a `fi` ligature that doesn't look great
      {family="Monaco Nerd Font", harfbuzz_features={"kern", "clig", "liga=0"}},
      -- {family="Monaco", harfbuzz_features={"kern", "clig", "liga=0"}},
      "MesloLGM Nerd Font",
      "Menlo",
      "Apple Color Emoji",
      "Hiragino Mincho ProN",
      -- {family="Monaco"},
    }, {weight="Regular"}),

  keys = {
    {key='Enter', mods='CMD', action='ToggleFullScreen'},
    {key='Enter', mods='ALT', action = wezterm.action.DisableDefaultAssignment},
    {key='p', mods='CMD', action=wezterm.action{ActivateTabRelative=-1}},
    {key='n', mods='CMD', action=wezterm.action{ActivateTabRelative=1}},
  },

  colors = {
    foreground = "#4d4c4b",
    background = "#eeeded",

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = "#000000",
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = "#FFFFFF",
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    -- cursor_border = "#52ad70",

    -- the foreground color of selected text
    selection_fg = "#eeeded",
    -- the background color of selected text
    selection_bg = "#4d4c4b",

    -- The color of the scrollbar "thumb"; the portion that represents the current viewport
    scrollbar_thumb = "#000000",

    -- The color of the split lines between panes
    split = "#718b00",

    -- ansi = {"black", "maroon", "green", "olive", "navy", "purple", "teal", "silver"},
    -- brights = {"grey", "red", "lime", "yellow", "blue", "fuchsia", "aqua", "white"},
    -- ansi = {"#4d4c4b", "#d6225e", "#718b00", "#d65e00", "#4270ad", "#8958a7", "#3e989e", "#eeeded"},
    ansi = {"#4d4c4b", "#d6225e", "#718b00", "#d65e00", "#4270ad", "#8958a7", "#3e989e", "#c0c0c0"},
    brights = {"#6e6d6b", "#d6225e", "#718b00", "#d65e00", "#4270ad", "#8958a7", "#3e989e", "#c0c0c0"},

    -- Arbitrary colors of the palette in the range from 16 to 255
    indexed = {[136] = "#af8700"},

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = "orange",

    tab_bar = {
      active_tab = { bg_color = "#513c7d", fg_color = "#c0c0c0", italic = true},
      inactive_tab = { bg_color = "#1b1032", fg_color = "#808080"},
      inactive_tab_hover = { bg_color = "#3b3052", fg_color = "#909090"},
      new_tab = { bg_color = "#1b1032", fg_color = "#808080"},
      new_tab_hover = { bg_color = "#3b3052", fg_color = "#909090"},
    },
  },
}
