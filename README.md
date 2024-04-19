# heimonsy's workspace

###  SETUP STEPS

``` bash

# install my tools
sudo apt install -y fish tmux ifstat htop curl wget git silversearcher-ag \
        build-essential python3-dev python3-pip ripgrep net-tools

# clone cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare https://github.com/heimonsy/cfg-sample.git $HOME/.cfg
config checkout
config config --local status.showUntrackedFiles no

# run sensors-detect if it is linux running on bare metal
# sudo sensors-detect

# Install neovim
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen libncurses5 clang
git clone https://github.com/neovim/neovim.git
cd neovim && git checkout RELEASE_VERSION
make CMAKE_BUILD_TYPE=Release
sudo make install

## neovim telescople requirements
- https://github.com/BurntSushi/ripgrep

# install go
wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz
tar zxf go1.19.1.linux-amd64.tar.gz
sudo mv go /usr/local/

# lemonade
go install github.com/lemonade-command/lemonade@latest

# 32bit gcc lib
sudo apt-get install gcc-multilib

# install node
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

# java env
# 最新的 eclipse language server 需要 11
sudo apt install openjdk-17-jdk openjdk-17-source maven

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install ctags
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=/where/you/want # defaults to /usr/local
make
make install # may require extra privileges depending on where to install

####################################
# project development related
####################################

# install golang tools

go get -d golang.org/x/tools/gopls
cd $GOPATH/src/golang.org/x/tools/gopls
go install .
cd -

wget https://github.com/protocolbuffers/protobuf/releases/download/v3.7.1/protoc-3.7.1-linux-x86_64.zip
sudo unzip -x -d /usr/local/ protoc-3.7.1-linux-x86_64.zip

go get -d github.com/golang/protobuf
cd $GOPATH/src/github.com/golang/protobuf/protoc-gen-go
go install .
cd -

go get -d github.com/jwilder/dockerize
cd $GOPATH/src/github.com/jwilder/dockerize
go install .
cd -

wget https://github.com/golangci/golangci-lint/releases/download/v1.22.2/golangci-lint-1.22.2-linux-amd64.tar.gz
tar zxf golangci-lint-1.21.0-linux-amd64.tar.gz
cp golangci-lint-1.21.0-linux-amd64/golangci-lint $GOPATH/bin/

# install docker
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER

sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


mkdir ~/.pip

cat > "$HOME/.pip/pip.conf" <<EOF
[global]
index-url=http://pypi.douban.com/simple
[install]
trusted-host=pypi.douban.com
EOF


pip3 install jupyter pylint numpy python-language-server

vim +"CocInstall coc-java"
vim +"CocInstall coc-python"

## gpg
#### 在另外一台机器
gpg --export-secret-keys key_hash > private.key
#### 在新机器
gpg --import private.key


```

## maven 镜像配置

```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                      http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <localRepository/>
  <interactiveMode/>
  <usePluginRegistry/>
  <offline/>
  <pluginGroups/>
  <servers/>
  <mirrors>
    <mirror>
     <id>aliyunmaven</id>
     <mirrorOf>*</mirrorOf>
     <name>阿里云公共仓库</name>
     <url>https://maven.aliyun.com/repository/public</url>
    </mirror>
     <mirror>
     <id>aliyunmaven</id>
     <mirrorOf>*</mirrorOf>
     <name>阿里云谷歌仓库</name>
     <url>https://maven.aliyun.com/repository/google</url>
    </mirror>
    <mirror>
     <id>aliyunmaven</id>
     <mirrorOf>*</mirrorOf>
     <name>阿里云阿帕奇仓库</name>
     <url>https://maven.aliyun.com/repository/apache-snapshots</url>
    </mirror>
    <mirror>
     <id>aliyunmaven</id>
     <mirrorOf>*</mirrorOf>
     <name>阿里云spring仓库</name>
     <url>https://maven.aliyun.com/repository/spring</url>
    </mirror>
    <mirror>
     <id>aliyunmaven</id>
     <mirrorOf>*</mirrorOf>
     <name>阿里云spring插件仓库</name>
     <url>https://maven.aliyun.com/repository/spring-plugin</url>
    </mirror>
  </mirrors>
  <proxies/>
  <profiles/>
  <activeProfiles/>
</settings>
```

### ubuntu fonts
```
sudo apt rdepends fonts-noto-color-emoji
sudo apt install fonts-noto-color-emoji
fc-cache -f -v
```

### Proxy

#### Socks5 to HTTP proxy

```
sudo apt-get install privoxy

## /etc/privoxy/config

forward-socks5t / 127.0.0.1:1080 .

sudo systemctl restart privoxy

```
