#!/bin/bash

setup_python(){
  #切换清华源
  sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main@' $PREFIX/etc/apt/sources.list
  pkg update -y && pkg upgrade -y
  
  #安装必要的软件包
  pkg install -y python git pip curl rust
  #下载并设置poetry
  curl -sSL https://install.python-poetry.org | python3 - || echo "安装失败！正在切换第二种安装方法……" && pip install poetry && echo "安装成功！" || echo "安装失败！请检查网络连接" && eixt 1
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bash_profile
  source ~/.bash_profile
  poetry install
}

setup_project(){
  echo "正在设置project依赖..."
  npm i -D typescript @types/frida-gum @types/node frida-compile frida-il2cpp-bridge frida-java-bridge
  npx tsc --init
  echo "设置完成！按任意键继续……"
  read
}

setup_project_alt(){
  echo "正在设置可选的project依赖……"
  npm i -D webpack webpack-cli
  echo "设置完成！按任意键继续……"
  read
}

echo "(1)设置python环境"
echo "(2)设置project环境"
echo "(3)设置project环境（可选）"
echo "(4)退出"
read -p "请选择(1/2/3/4): " confirm

confirm=${confirm:-1} 
if [ "$confirm" = "1" ]; then
    setup_python
elif [ "$confirm" = "2" ]; then
    setup_project
elif [ "$confirm" = "3" ]; then
    setup_project_alt
elif [ "$confirm" = "4" ]; then
    echo "已退出"
    exit 0
else
    echo "无效选择"
    exit 1
fi

exit 0
