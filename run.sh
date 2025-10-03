#!/data/data/com.termux/files/usr/bin/bash

# 选择启动模式
echo "脚本将执行以下操作："
echo "1. 启用无线ADB并设置端口为5555"
echo "2. 重启ADB服务"
echo "3. 切换到指定目录开始执行"
read -p "请选择启动模式（1）普通模式（2）无代理模式（3）退出 (1/2/3)(默认：1): " confirm
confirm=${confirm:-1} 
if [ "$confirm" = "1" ]; then
    echo "启动普通模式"
    # 普通模式命令
elif [ "$confirm" = "2" ]; then
    echo "启动无代理模式"
    # 无代理模式命令
elif [ "$confirm" = "3" ]; then
    echo "退出程序"
    exit 0
else
    echo "无效选择"
    exit 1
fi

# 启用无线ADB
tsu -s "setprop service.adb.tcp.port 5555"
tsu -s "stop adbd"
tsu -s "start adbd"
sleep 2

# 检查frida是否安装
if ! python -c "import frida" 2>/dev/null; then
    echo "Error: 未检测到frida."
    echo "请输入 run ./setup.sh 以下载frida."
    exit 1
fi

# 在系统Python环境下运行（frida安装在系统环境中）
# 设置PYTHONPATH以包含项目源代码
export PYTHONPATH="$PWD/src/launcher:$PYTHONPATH"
python -m openbachelorc.main

echo "按任意键继续……"
read -r
