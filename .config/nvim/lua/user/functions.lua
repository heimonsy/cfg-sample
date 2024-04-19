
local function pfiles()
  local rootDir = vim.api.nvim_exec([[
    echo system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
  ]], true)

  require('telescope.builtin').find_files({
    cwd = rootDir
  })
end

local function search_def()
  local searchString = vim.api.nvim_exec([[
    " echo ' ' . expand("<cword>") . '\('
    echo '^func( .+ | )' . expand("<cword>") . '\('
  ]], true)
  require('telescope.builtin').grep_string({ search = searchString , use_regex = true})
end

local function search_ref()
  local searchString = vim.api.nvim_exec([[
    " echo ' ' . expand("<cword>") . '\('
    echo '.' . expand("<cword>") . '('
  ]], true)
  require('telescope.builtin').grep_string({ search = searchString })
end


vim.cmd([[
" 查找/搜索
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        execute "vimgrep /" . l:pattern . "/" . " **/*"
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! FindGitRoot()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function! TeleFindFiles()
  let rootDir = FindGitRoot()
  echo rootDir
  lua require('telescope.builtin').find_files({ cwd = rootDir })
endfunction

" 显示包名或目录名
function! PackageName()
  let parts = split(expand('%:p:h'), "/")
  if len(parts) == 0
    return ""
  endif
  return ' ' . parts[len(parts)-1]
endfunction

function! OpenSCM()
    let origin = substitute(system('git remote get-url origin'), '.git\n$', '', '')
    let file0 = substitute(expand('%:p'), FindGitRoot(), '', '')
    let branch = substitute(system('git branch --show-current'), '\n', '', '')
    let url = origin . "/-/blob/". branch . file0 . "#L" . line(".")
    if stridx(origin, "/github.com/") >= 0
        let url = origin . "/blob/". branch . file0 . "#L" . line(".")
    endif
    echo url
    return system("open " . url)
endfunction

command! OpenSCM :call OpenSCM()

function! EchoTagName()
  echo "TagName: " . TagName()
endfunction

function! TagName()
  let tag = luaeval('require("nvim-navic").get_location({separator=""})')
  " let tag = tagbar#currenttag("%s",  "",  "f", "nearest")
  " let tag=trim(NearestMethodOrFunction(), "()")

  if len(tag) == 0
    return ""
  endif

  " split tag="󰊕 TestHaha" with empty space
  let [_, tag] = split(tag, " ")

  if stridx(tag, ".") >= 0
    let cStart = stridx(tag, "(") + 1
    let cEnd = stridx(tag, ")")
    if stridx(tag, "*") >=0
      let cStart = stridx(tag, "*") + 1
    endif

    let mStart = stridx(tag, ".") + 1
    let mEnd = len(tag)
    return strpart(tag, cStart, cEnd-cStart) . "_" . strpart(tag, mStart, mEnd-mStart)

  endif

  return tag
endfunction

" 测试当前的函数
function! FunctionTest()
    let fnname=TagName()

    let first = strpart(fnname, 0, 1)

    set noignorecase
    if first == tolower(first)
      set ignorecase
      let fnname = "_" . fnname
    endif
    set ignorecase


    if fnname !~ "^Test"
        let fnname="Test" . fnname
    end

    call SplitAndRun(expand("%:p:h") . "//go test -v -run " . fnname )
endfunction

" 测试当前的函数
function! GoBuild()
    call SplitAndRun(expand("%:h") ."//go build ")
endfunction

function! MyBuild()
    if &filetype == "go"
        call GoBuild()
        return
    endif

    if &filetype == "java"
      if filereadable("build.gradle")
        call SplitAndRun(".//gradle compileJava")
      else
        call SplitAndRun(".//mvn compile -DskipTests")
        " call SplitAndRun(".//JAVA_HOME=" . $JAVA_HOME . " mvn compile -DskipTests" )
      endif
      return
    endif

    execute 'normal! \<Esc>'
    echohl ErrorMsg
    echomsg "[MyBuild Error] ". &filetype ." not supported!"
    echohl None
    return
endfunction

" 测试当前的函数
function! FunctionTestAll()
  call SplitAndRun(expand("%:h") ."//go test -v")
endfunction

function! JavaRun()
    if &filetype != "java"
        execute 'normal! \<Esc>'
        echohl ErrorMsg
        echomsg "[JavaRun Error] not java file!"
        echohl None
        return
    endif

    let fullClass = JavaFullClass()
    if filereadable("build.gradle")
      call SplitAndRun(".//gradlerun " . fullClass)
    else
      call SplitAndRun(".//mvnrun " . fullClass)
      " call SplitAndRun(".//JAVA_HOME=" . $JAVA_HOME . " mvnrun " . fullClass)
    endif
    return
endfunction

function! JavaFullClass()
    let [lnum, _] = searchpos('^package .\+;', 'n')
    if lnum == 0
        return "unknow"
    endif

    let [main, _] = searchpos('public static void main(String[] args)', 'n')
    if main == 0
        return ""
    endif

    let packageName = trim(split(getline(lnum), " ")[1], ";")
    let className = expand('%:t:r')
    return packageName . '.' . className
endfunction

function JR()
    if &filetype == "go"
        call GRun()
        return
    endif

    if &filetype == "java"
        call JavaRun()
        return
    endif

    execute 'normal! \<Esc>'
    echohl ErrorMsg
    echomsg "[JR Error] ". &filetype ." not supported!"
    echohl None
    return
endfunction

function RustRun()
    if &filetype != "go"
        execute 'normal! \<Esc>'
        echohl ErrorMsg
        echomsg "[RustRun Error] not rust file!"
        echohl None
        return
    endif

    call SplitAndRun(expand("%:p:h") . "//rustc ")
endfunction

function GRun()
    if &filetype != "go"
        execute 'normal! \<Esc>'
        echohl ErrorMsg
        echomsg "[GRun Error] not go file!"
        echohl None
        return
    endif

    call SplitAndRun(expand("%:p:h") . "//go run .")
endfunction


function SplitAndRun(termStr)
  let l:curw = winnr()
  :exe "normal \<C-J>"

  " 下面没有 window
  if winnr() == l:curw
    execute ":split term://" . a:termStr
    :exe "normal \<C-J>"
    :resize 15
    :exe "normal \<S-G>"
    return
  endif


  " 下面的 window 不是 term://
  if expand("%")[0:6] != "term://"
    execute ":tabnew term://" . a:termStr
    return
  else

  :bd!

  execute ":split term://" . a:termStr
  :exe "normal \<C-J>"
  :resize 15
  :exe "normal \<S-G>"
  return
endfunction

function FFormat()
  let v = winsaveview()
  call RealFormat001()
  call winrestview(v)
  :w
endfunction

function RealFormat001()
lua << EOF
if vim.lsp.buf.format == null then
  vim.lsp.buf.formatting_sync()
else
  vim.lsp.buf.format({ async = false })
end
EOF
endfunction

function CloseOtherBuffers() 
  " :%bd|e#|bd#
  " :exe "normal zz"
  :BufferLineCloseRight
  :BufferLineCloseLeft
endfunction

function CtrlC()
  " echo expand("%")
  if winnr() != 1 && expand("%")[0:6] != "term://"
    :close!
    if expand("%")[0:8] == "NvimTree_"
      :bd!
    endif
    return
  endif

  if stridx(expand("%"), "fugitiveblame") >= 0
    :bd!
    return
  endif

  if getbufvar(bufnr(@%), '&buftype', 'ERROR') == "terminal"
    :bd!
    return
  endif

  :Bdelete
endfunction

function NormalNextFnArg()
  let c = matchstr(getline('.'), '\%'.col('.').'c.')
  while c != '"' && c != ')' && c != '\n' && c != ';'
    normal! l
    let c = matchstr(getline('.'), '\%'.col('.').'c.')
  endwhile

  if c == '"'
      normal! a, 
      normal! l
      startinsert
  endif
  if c == ')'
      normal! i, 
      normal! l
      startinsert
  endif
endfunction

function InsertNextFnArg()
  stopinsert!

  let line = getline('.')
  let pos = col('.')-1 " IIRC
  let line = line[:pos-1] . "TTT" . line[pos:]
  call setline('.', line)

endfunction

]])


vim.api.nvim_create_user_command("PFiles", pfiles, {})
vim.api.nvim_create_user_command("SearchDef", search_def, {})
vim.api.nvim_create_user_command("SearchRef", search_ref, {})
vim.api.nvim_create_user_command("Gb", "Git blame", {})
