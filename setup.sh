#!/bin/bash

setup_python(){
  #切换清华源
  sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main@' $PREFIX/etc/apt/sources.list
  pkg update -y && pkg upgrade -y
  
  #安装必要的软件包
  pkg install -y python git curl rust
  #下载并设置poetry
  curl -sSL https://install.python-poetry.org | python3 - || {
  echo "安装失败！正在切换第二种安装方法……"
  pkg install -y pip && pip install poetry && echo "安装成功！" || {
    echo "安装失败！请检查网络连接"
    exit 1
  }
}
  source ~/.bash_profile
  # 检查Poetry项目配置文件，存在时才执行install
  if [ -f "pyproject.toml" ]; then
    echo "正在安装Python项目依赖（poetry install）..."
    poetry install
  else
    echo "未找到pyproject.toml，跳过poetry install"
  fi
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

python_frida(){
    # Check if version is provided as argument
    if [ -z "$1" ]; then
        echo "Usage: $0 <frida-version>"
        echo "Example: $0 17.0.7"
        echo "Example: $0 16.5.9"
        exit 1
    fi
    
    FRIDA_VERSION_ARG="$1"
    
    if ! command -v termux-setup-storage &>/dev/null; then
      echo "该脚本只能在termux上运行"
      exit 1
    fi
    
    # Detect architecture
    case "$(uname -m)" in
        aarch64)
            arch="arm64"
            ;;
        armv7l | armv8l)
            arch="arm"
            ;;
        x86_64)
            arch="x86_64"
            ;;
        x86)
            arch="x86"
            ;;
        *)
            echo "系统架构无法识别: $(uname -m)"
            exit 1
            ;;
    esac
    
    cd $TMPDIR || exit 1
    
    # Update and install required packages
    apt update && pkg upgrade -y
    pkg i -y python git curl && pip install -U setuptools
    
    # Use the specified Frida version
    FRIDA_VERSION="$FRIDA_VERSION_ARG"
    echo "安装Frida版本: $FRIDA_VERSION"
    
    # Download Frida devkit for specified version
    DEVKIT_URL="https://github.com/Alexjr2/Frida_Termux_Installation/releases/download/$FRIDA_VERSION/frida-core-devkit-android-$arch.tar.xz"
    DEVKIT_FILE="frida-core-devkit-android-$arch.tar.xz"
    
    echo "下载Frida devkit从: $DEVKIT_URL"
    if ! curl -L -o "$DEVKIT_FILE" "$DEVKIT_URL"; then
        echo "Error:Frida devkit下载失败."
        rm -f "$DEVKIT_FILE"  # 清理部分下载
        exit 1
    fi
    
    # Check if download was successful (file exists and has content)
    if [ ! -f "$DEVKIT_FILE" ] || [ ! -s "$DEVKIT_FILE" ]; then
        echo "Error: 无法下载Frida devkit或文件为空.请检查版本$FRIDA_VERSION是否存在."
        echo "请确认版本在: https://github.com/Alexjr2/Frida_Termux_Installation/releases"
        rm -f "$DEVKIT_FILE"  # Clean up empty file
        exit 1
    fi
    
    # Clean up any existing devkit directory
    if [ -d "devkit" ]; then
        echo "清理现有的devkit目录……"
        rm -rf devkit
    fi
    
    # Extract devkit
    mkdir -p devkit && tar -xJvf "$DEVKIT_FILE" -C devkit
    
    # Clean up any existing frida-python directory
    if [ -d "frida-python" ]; then
        echo "清理现有的frida-python目录..."
        rm -rf frida-python
    fi
    
    # Clone and install Frida Python with specified version
    echo "克隆frida-python版本: $FRIDA_VERSION"
    if ! git clone -b "$FRIDA_VERSION" --depth 1 https://github.com/frida/frida-python.git; then
        echo "Error: 无法克隆frida-python 版本 $FRIDA_VERSION.请检查版本号是否正确."
        echo "请确认版本 $FRIDA_VERSION 存在于 https://github.com/frida/frida-python/releases"
        exit 1
    fi
    
    # fix setup.py
    cd frida-python || exit 1
    curl -LO https://raw.githubusercontent.com/Alexjr2/Frida_Termux_Installation/refs/heads/main/frida-python.patch
    patch -p1 < frida-python.patch
    
    #install frida-python
    echo "正在安装 Frida Python 版本 $FRIDA_VERSION..."
    if FRIDA_VERSION="$FRIDA_VERSION" FRIDA_CORE_DEVKIT="$PWD/../devkit" pip install --force-reinstall .; then
        echo "成功安装 Frida Python 版本 $FRIDA_VERSION!"
        echo "你现在可以使用: import frida in Python"
    else
        echo "Error: Frida Python 安装失败."
}

echo "(1)设置python环境"
echo "(2)设置project环境"
echo "(3)设置project环境（可选）"
echo "(4)安装frida"
echo "(5)退出"
read -p "请选择(1/2/3/4): " confirm

confirm=${confirm:-1} 
if [ "$confirm" = "1" ]; then
    setup_python
elif [ "$confirm" = "2" ]; then
    setup_project
elif [ "$confirm" = "3" ]; then
    setup_project_alt
elif [ "$confirm" = "4" ]; then
    python_frida
elif [ "$confirm" = "5" ]; then
    echo "已退出"
    exit 0
else
    echo "无效选择"
    exit 1
fi

exit 0
