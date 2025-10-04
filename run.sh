#!/data/data/com.termux/files/usr/bin/bash

enable_adb(){
echo "脚本将执行以下操作："
echo "1. 启用无线ADB并设置端口为5555"
echo "2. 重启ADB服务"
echo "3. 切换到指定目录开始执行"
tsu -s "setprop service.adb.tcp.port 5555"
tsu -s "stop adbd"
tsu -s "start adbd"
sleep 2
}

start(){
    echo "启动普通模式"
    enable_adb
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
    echo "按任意键继续……"&&read -r
}

start_no_proxy(){
    echo "启动无代理模式"
    enable_adb
    python -m openbachelorc.main --no-proxy
    echo "按任意键继续……"&&read -r
}

# 功能选择
echo "功能列表"
echo "（1）正常启动"
echo "（2）无代理启动"
echo "（3）退出"
read -p "请选择(1/2/3)(默认：1): " confirm

confirm=${confirm:-1} 
if [ "$confirm" = "1" ]; then
    start
elif [ "$confirm" = "2" ]; then
    start_no_proxy
elif [ "$confirm" = "3" ]; then
    echo "已退出"
    exit 0
else
    echo "无效选择"
    exit 1
fi

exit 0


