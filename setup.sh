#!/bin/bash
#切换清华源
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main@' $PREFIX/etc/apt/sources.list
pkg update -y && pkg upgrade -y

#安装必要的软件包
pkg install -y python git curl rust
#下载并设置poetry
curl -sSL https://install.python-poetry.org | python3 -
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
poetry self update
poetry install
