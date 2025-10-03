#!/bin/bash

build_js(){
  echo "构建JavaScript文件..."
  mkdir -p tmp
  npx frida-compile -S src/script/native/index.ts -o tmp/native.js
  npx frida-compile -S src/script/java/index.ts -o tmp/java.js
  npx frida-compile -S src/script/extra/index.ts -o tmp/extra.js
  npx frida-compile -S src/script/trainer/index.ts -o tmp/trainer.js
  echo "构建完成！按任意键继续……"
  read
}

build_js_alt(){
echo "构建JavaScript文件 (可选方法)..."
npx tsc
npx webpack -o tmp/alt/
echo "构建完成！按任意键继续……"
read
}

# 功能选择
echo "功能列表"
echo "（1）构建JavaScript文件"
echo "（2）构建JavaScript文件（可选）"
echo "（3）退出"
read -p "请选择(1/2/3): " confirm
if [ "$confirm" = "1" ]; 
    build_js
elif [ "$confirm" = "2" ]; 
    build_js_alt
elif [ "$confirm" = "3" ]; 
    echo"已退出"
    exit 0
else
    echo "无效选择"
    exit 1
fi

exit 0
