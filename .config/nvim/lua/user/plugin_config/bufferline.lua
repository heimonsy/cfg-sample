local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup {
  options = {
    numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    left_trunc_marker = "",
    right_trunc_marker = "",
    diagnostics = false, -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    offsets = { { filetype = "NvimTree", text = "File Explorer", padding = 1} },
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "slant",
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    tab_size = 12,

    -- groups = {
    --   options = {
    --     toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
    --   },
    --   items = {
    --     {
    --       name = "Tests", -- Mandatory
    --       highlight = {underline = false, sp = "blue"}, -- Optional
    --       priority = 2, -- determines where it will appear relative to other groups (Optional)
    --       icon = "", -- Optional
    --       auto_close = true,
    --       matcher = function(buf) -- Mandatory
    --         return buf.filename:match('%_test.go') or buf.filename:match('%_test') or buf.filename:match('%_spec')
    --       end,
    --     },
    --     {
    --       name = "Docs",
    --       highlight = {undercurl = false, sp = "green"},
    --       auto_close = true,  -- whether or not close this group if it doesn't contain the current buffer
    --       icon = "",
    --       matcher = function(buf)
    --         return buf.filename:match('%.md') or buf.filename:match('%.txt')
    --       end,
    --     },
    --   },
    -- },
  },
}
