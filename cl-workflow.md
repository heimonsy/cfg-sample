# 命令行工作流

## Terminal

- Wezterm
  - [wezterm](https://wezfurlong.org/wezterm/)
  - 配置文件： `~/.config/wezterm/wezterm.lua`
  - 快, 自带 nerdfont, 配置简单


- Kitty
  - [kitty](https://sw.kovidgoyal.net/kitty/)

## Tmux

方便的终端复用工具.

- 配置文件： `~/.tmux.conf`

## Neovim
  - [neovim](https://neovim.io/)
  - 配置文件： `~/.config/nvim/init.lua`
  - 插件管理： [lazy.nvim](https://github.com/folke/lazy.nvim)
  - 懒人专用一键配置: [LazyVim](https://www.lazyvim.org/)

## Shell

- fish
  - [fish-shell](https://fishshell.com/)
  - 配置文件(类似于 .bashrc)： `~/.config/fish/config.fish`
  - plugins/customization: `~/.config/fish/functions/`


- zsh
  - [oh-my-zsh](https://ohmyz.sh/)


## 工具

- [fzf](https://github.com/junegunn/fzf)
  - 命令行模糊搜索工具
  - 安装： `brew install fzf`
    - 或 clone/download 仓库，然后运行 `install` 脚本
    - 我一般下载到 `~/.fzf` 目录下，然后运行 `~/.fzf/install`
  - 使用： `ctrl + r` 搜索历史命令，`ctrl + t` 搜索文件即可

- find
  - `find . -name "*.md"` 查找当前目录下所有 `.md` 文件
  - 与 grep 连用： `find . -name "*.md" | xargs grep "keyword"`
  - 与 ag 连用： `find . -name "*.md" | xargs ag "keyword"`

- grep
  - `grep -r "keyword" .` 在当前目录下递归搜索 `keyword`
  - "-v": 反向搜索，即不包含 `keyword` 的行

- ag
  - `ag "keyword" .` 在当前目录下递归搜索 `keyword`
  - 比 grep 更快，更好用
  - 与 grep 连用： `ag "keyword" . | grep -v "another keyword"`

## Git

```
[alias]
    lg1 = log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(black)%s%C(reset) %C(bold black)— %an%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative
    lg2 = log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(black)%s%C(reset) %C(bold black)— %an%C(reset)' --abbrev-commit
    cr1 = fetch --all --prune
    up = "!git remote update -p; git merge --ff-only @{u}"

[http]
    ; https://stackoverflow.com/questions/15227130/using-a-socks-proxy-with-git-for-the-http-transport
    ; proxy = socks5h://
    ; proxy = socks5://
    ; proxy = 192.168.70.1:7777
[https]
    ;proxy = 192.168.70.1:7777

[core]
    editor = vim -f
    pager = diff-so-fancy | less --tabs=4 -RFX

[color]
    ui = true

[interactive]
    ; https://github.com/so-fancy/diff-so-fancy
    diffFilter = diff-so-fancy --patch

[color "diff"]
    meta = 11
    frag = magenta bold
    func = blue bold
    commit = yellow bold
    old = red bold
    new = green bold
    whitespace = red reverse

; 决定是否保存密码以及保存的方式
; https://git-scm.com/book/en/v2/Git-Tools-Credential-Storage
[credential]
    helper = store
```

- git commit --amend
  - 修改最近一次 commit 的信息

- git rebase -i HEAD~3
  - 交互式 rebase，可以合并 commit，修改 commit 信息等
