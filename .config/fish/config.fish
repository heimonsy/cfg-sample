set -x LANG en_US.UTF-8
set -x LANGUAGE en_US.UTF-8
set -x LC_TYPE en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x FISH_PATH $HOME/.config/fish

if uname -a | grep -q "ARCH"
    set -x GOROOT /usr/lib/go
else
    set -x GOROOT /usr/local/go
end

set -x TERM xterm-256color

set -x GOPATH $HOME/Develop/go


set -x GO111MODULE on

set -g theme_date_format "+%Y-%m-%d %H:%M:%S"

# 统一 mac 和 ubuntu 的权限
umask 0022

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

set -x PATH $GOROOT/bin $HOME/.local/share/nvim/lsp_servers/go $HOME/Develop/go/bin $HOME/.cargo/bin $HOME/bin /usr/local/sbin $PATH

if uname -a | grep -q "Darwin"
	set -x JAVA_HOME /opt/homebrew/opt/openjdk@17
	set -x PATH /opt/homebrew/bin $PATH
	set -x MY_OS_SYMBOL ''

else
	set -x MY_OS_SYMBOL ''

	set arch (uname -m)
	if arch | grep -q "aarch64"
		set -x JAVA_HOME /usr/lib/jvm/java-17-openjdk-arm64
	else
		set -x JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
	end

	set -x PATH $HOME/bin/gradle-7.5/bin $HOME/.local/bin /snap/bin $DENO_INSTALL/bin $HOME/bin/apache-maven/bin $HOME/bin/spring-boot-cli/spring-2.7.1/bin $PATH
	set -gx PNPM_HOME "/home/heimonsy/.local/share/pnpm"
	set -gx PATH "$PNPM_HOME" $PATH
	set -x GRADLE_HOME $HOME/bin/gradle-7.5
end

# set -x GOPROXY https://goproxy.io,direct
# set -x GOPRIVATE xx,xx

if [ -f "$HOME/.cargo/env" ];
	bash "$HOME/.cargo/env"
end

# set -x DENO_INSTALL "/home/heimonsy/.deno"
set -x BUF_USER heimonsy

# windows wsl only
# set -x PATH /usr/local/go/bin $HOME/.local/bin /home/heimonsy/.local/share/nvim/lsp_servers/go /home/heimonsy/Develop/go/bin /home/heimonsy/bin /usr/local/sbin /home/heimonsy/.fzf/bin /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games /usr/local/games /usr/lib/wsl/lib

# disable virual env prompts (only show fish prompts)
set -x VIRTUAL_ENV_DISABLE_PROMPT true

# MacOS
# set -x PATH /opt/homebrew/bin /usr/local/go/bin $HOME/.local/share/nvim/lsp_servers/go $HOME/Develop/go/bin $HOME/.cargo/bin $HOME/bin /usr/local/sbin /opt/homebrew/opt/fzf/bin /usr/local/bin /usr/bin /bin /usr/sbin /sbin $HOME/Library/Python/3.9/bin
