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

config_setting_trainer(){
  read -p "启用训练器? (y/n) " choice
  if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
      value=true
  else
      value=false
  fi
  
  mkdir -p tmp
  jq --indent 4 ".trainer_enabled = $value" conf/config.json > tmp/config.json
  mv tmp/config.json conf/config.json
}

load_config(){
  mkdir -p tmp
  jq --indent 4 ".use_su = false | .use_gadget = false" conf/config.json > tmp/config.json
  mv tmp/config.json conf/config.json
}

clean(){
    # 删除临时文件
    rm -rf tmp/
    rm -rf node_modules/
    rm -rf .venv/
    rm -rf __pycache__/
    rm -rf *.pyc
    rm -rf .pytest_cache/
    
    # 移除Poetry虚拟环境
    python -m pipx run poetry env remove --all 2>/dev/null || true
    
    echo "清理完成！按任意键继续……"
    read
}

# 功能选择
echo "功能列表"
echo "（1）构建JavaScript文件"
echo "（2）构建JavaScript文件（可选）"
echo "（3）设置trainer参数"
echo "（4）加载config.json"
echo "（5）清理运行环境"
echo "（5）退出"
read -p "请选择(1/2/3/4/5/6): " confirm

if [ "$confirm" = "1" ]; then
    build_js
elif [ "$confirm" = "2" ]; then
    build_js_alt
elif [ "$confirm" = "3" ]; then
    config_setting_trainer
elif [ "$confirm" = "4" ]; then
    load_config
elif [ "$confirm" = "5" ]; then
    clean
elif [ "$confirm" = "6" ]; then
    echo "已退出"
    exit 0
else
    echo "无效选择"
    exit 1
fi

exit 0
