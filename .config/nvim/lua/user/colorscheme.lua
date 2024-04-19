
-- vim.api.nvim_set_hl(0, "@type", { link = "Identifier" });

vim.cmd([[
  " TODO tree colors support
  " https://jdhao.github.io/2018/10/19/tmux_nvim_true_color/
  " set t_co=256

  set termguicolors
  set background=light
  colorscheme PaperColor
  set termguicolors

  " " "
  " highlight TSPunctSpecial guifg=#004e3d
  " highlight TSConstBuiltin guifg=#4c3d3d
  " " highlight TSConstructor gui=Bold guifg=#533636
  " highlight TSVariableBuiltin guifg=#5f0000
  " highlight TSStringRegex guifg=#855f00
  " highlight TSLiteral guifg=#508500
  " highlight TSField guifg=#004785
  " highlight TSProperty guifg=#444444
  " highlight TSParameterReference guifg=#005685
  " highlight TSAttribute guifg=#185d95
  " highlight TSTag guifg=#305b7e
  " highlight TSKeywordFunction guifg=#d70087 gui=Bold
  " highlight TSKeywordReturn gui=Bold guifg=#d70087
  " highlight TSNamespace guifg=#444444
  " highlight TSParameter guifg=#444444
  " highlight TSPunctDelimiter guifg=#573232
  " highlight TSPunctBracket guifg=#444444
  " highlight TSConditional gui=Bold guifg=#d70087
  "
  " highlight javascriptTSTag guifg=#d75f00
  " highlight javascriptTSConstructor guifg=#8700af
  "
  "
  " """"""""""""""""""""""""""
  " " 自定义颜色
  " """"""""""""""""""""""""""
  " highlight TSBoolean gui=Bold guifg=#d75f00
  " highlight TSInclude gui=Bold guifg=#d70087
  " highlight TSKeyword gui=Bold guifg=#d70087
  " " highlight TSFunction gui=Bold guifg=#005faf
  "
  " " highlight TSTagAttribute guifg=#d75f00
  "
  " highlight TSFunctionCall gui=None guifg=#005faf
  " highlight TSFuncBuiltin guifg=#8700af
  " highlight TSMethod guifg=#005faf
  " highlight TSOperator guifg=#5f0000
  " highlight Operator guifg=#5f0000
  " highlight TSRepeat guifg=#d70087
  " highlight TSType guifg=#444444
  " highlight TSVariable guifg=#444444
  " " highlight TSTypeBuiltin gui=None guifg=#8700af
  " highlight TSKeywordOperator gui=None guifg=#d70087
  " highlight TSTagDelimiter guifg=#005f87
  "
  "
  "
  " """"""""""""""""
  " " vim-go 自定义"
  " """"""""""""""""""
  " highlight def link goFunctionCall TSMethod
  " highlight goFunction        gui=Bold guifg=#005faf
  " highlight goEscapeC         gui=Bold
  " highlight goDeclaration     gui=Bold guifg=#d70087
  " highlight goStatement       gui=Bold guifg=#d70087
  " highlight goPackage         gui=Bold guifg=#d70087
  " highlight goImport          gui=Bold guifg=#d70087
  " highlight goVar             gui=Bold guifg=#d70087
  " highlight goType            guifg=#d70087
  " highlight goOperator        guifg=#5f0000
  " highlight goBoolean         gui=Bold guifg=#008700
  " highlight goSignedInts      guifg=#d70087
  " highlight goUnsignedInts    guifg=#d70087
  " highlight goFloats          guifg=#d70087
  " highlight goComplexes       guifg=#d70087
  " highlight goDeclType        gui=None guifg=#d70087
  " highlight goPredefinedIdentifiers gui=Bold guifg=#008700
  "
  "
  " """"""""""""""""""
  " "
  " """"""""""""""""
  " highlight DiagnosticVirtualTextWarn gui=italic guifg=#ffd700
  "
  " """"""""""""""""
  " " rust 自定义
  " """"""""""""""""""
  " highlight rustOperator guifg=#5f0000 gui=None
  " highlight rustSigil guifg=#5f0000 gui=None
  
  "
  "

  """"""""""""""""
  " TS 自定义
  """""""""""""""""
  highlight @namespace guifg=#444444
  highlight @constant guifg=#444444
  highlight @parameter guifg=#444444
  highlight @property guifg=#444444
  highlight @field guifg=#444444
  highlight @constant.builtin gui=Bold guifg=#008700
  highlight @punctuation.bracket guifg=#444444
  highlight @punctuation.delimiter guifg=#573232
  highlight @function.builtin gui=None guifg=#8700af
  highlight @variable guifg=#444444
  highlight @variable.builtin guifg=#8700af
  highlight @method gui=Bold guifg=#005faf
  highlight @method.call gui=None guifg=#005faf
  highlight @tag.attribute guifg=#d75f00
  highlight @constructor guifg=#005faf
  highlight @keyword gui=Bold guifg=#d70087
  highlight @type guifg=#444444
  highlight @operator guifg=#5f0000
  highlight Type gui=None guifg=#d70087
  highlight @type.builtin gui=None guifg=#d70087
  highlight @type.qualifier gui=Bold guifg=#d70087
  highlight @type.definition guifg=#444444
  highlight @tag guifg=#005faf
  highlight @function gui=Bold guifg=#005faf
  highlight @function.call gui=None guifg=#005faf
  highlight @exception guifg=#af0000 gui=Bold

  " highlight @type.java guifg=#007b91
  " highlight @type.definition.java guifg=#005faf gui=Bold
  " highlight @type.java guifg=#005faf gui=Bold
  " highlight @field.java guifg=#005faf
  " highlight @type.java gui=None guifg=#005faf
  highlight @field.java guifg=#007788 gui=italic

  " highlight @type.cpp guifg=#005fff gui=None

  " highlight @field.cpp guifg=#007788 gui=italic
  " highlight @property.cpp guifg=#007788 gui=italic


  " highlight @method.call.java guifg=#005faf gui=Bold
  " highlight @method.call.java guifg=#005faf gui=None

  highlight @field.yaml guifg=#d70087

  " markdown
  highlight @text.title.1.marker gui=Bold guifg=#005faf
  highlight @text.title.1 gui=Bold guifg=#005faf
  highlight @text.title.2.marker gui=Bold guifg=#005faf
  highlight @text.title.2 gui=Bold guifg=#005faf
  highlight @text.title.3.marker gui=Bold guifg=#005faf
  highlight @text.title.3 gui=Bold guifg=#005faf
  highlight @text.title.4.marker gui=Bold guifg=#005faf
  highlight @text.title.4 gui=Bold guifg=#005faf
  highlight @text.literal guifg=#d70000

  """"""""""""""""
  " semantic_tokens 自定义
  """""""""""""""""
  " highlight link @lsp.type.class              @type.java
  " highlight link @lsp.type.class.definition   @type.java
  "
  " highlight link @lsp.type.method          @method
  " highlight link @lsp.type.parameter       @parameter
  " highlight link @lsp.type.variable        @variable
  " highlight link @lsp.type.property        @parameter

  """"""""""""""""
  " term
  """""""""""""""""

  let g:terminal_color_0  = "#4d4c4b"
  let g:terminal_color_1  = "#65225e"
  let g:terminal_color_2  = "#718b00"
  let g:terminal_color_3  = "#d65e00"
  let g:terminal_color_4  = "#4270ad"
  let g:terminal_color_5  = "#8958a7"
  let g:terminal_color_6  = "#3e898e"
  let g:terminal_color_7  = "#c0c0c0"
  let g:terminal_color_8  = "#6e6d6b"
  let g:terminal_color_9  = "#d6225e"
  let g:terminal_color_10 = "#718b00"
  let g:terminal_color_11 = "#d65e00"
  let g:terminal_color_12 = "#4270ad"
  let g:terminal_color_13 = "#8958a7"
  let g:terminal_color_14 = "#3e898e"
  let g:terminal_color_15 = "#c0c0c0"

  """"""""""""""""
  " 自定义其它
  """""""""""""""""
  highlight FloatBorder guifg=#444444 guibg=#EEEEEE
  highlight NormalFloat guifg=#444444 guibg=#EEEEEE

  highlight CursorLine          guifg=none         guibg=#e4e4e4  gui=none
  highlight CursorLineNr        guifg=#af5f00      guibg=none     gui=none

  highlight DiagnosticVirtualTextError gui=italic guifg=#C00000 guibg=#ffd5ff
  highlight VertSplit guifg=#bcbcbc guibg=#e4e4e4

  " 不知道为什么，不手动设置一下 CursorLine 就会在 tab 字符的地方失效"
  highlight Whitespace guifg=#bcbcbc

  highlight LspReferenceText guibg=#c2c2c2  " lsp document highlight
  highlight TelescopeMatching guifg=#00afaf
highlight GitSignsAdd guifg=#008700 guibg=#a0ffa0
  highlight GitSignsChange guifg=#444444 guibg=#b0b0b0
  highlight GitSignsDelete guifg=#af0000 guibg=#ff8686

  highlight cFormat           guifg=#444444
  highlight goFormatSpecifier guifg=#444444
  highlight myGoFormatSpecifier guifg=#444444

  highlight markdownCode      guifg=#5f8700 gui=bold

  hi TreesitterContext gui=underline guibg=#d0dce0
  hi TreesitterContextLineNumber gui=underline guibg=#d0dce0
]])
