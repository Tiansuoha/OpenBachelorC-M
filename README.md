# OpenBachelorC-M for Termux 使用手册

## 概述

本手册旨在指导您在 Android 设备上的 Termux 环境中部署和运行 OpenBachelorC-M 自动化工具。该工具是 [OpenBachelorC](https://github.com/pfyy/OpenBachelorC) 的修改与移植版本。

## 前提条件

- **Android 设备**：系统版本为 Android 11 或更高。
- **Termux 应用**：从 [F-Droid](https://f-droid.org/en/packages/com.termux/) 下载安装，**请勿使用已停止更新的 Play Store 版本**。
- **修补后的 PvZ Online APK**：准备好修改版游戏客户端。[OpenBachelorG](https://github.com/pfyy/OpenBachelorG)
- **OpenBachelorC-M 项目文件**：获取完整的 `OpenBachelorC-M` 文件夹。
- **备份文件**：`backup.tar.xz`，其中包含预配置的 Termux 环境。

---

## 第一阶段：准备工作

### 1. 安装 Termux 与游戏

从 F-Droid 安装 Termux，并安装修补后的 PvZ Online APK 文件。

### 2. 放置必要文件

- 将 `OpenBachelorC-M` 文件夹放置到手机内部存储的 `Download` 目录：

  ```
  内部存储/Download/OpenBachelorC-M/
  ```

- 将 `backup.tar.xz` 文件放置到手机内部存储的根目录：

  ```
  内部存储/backup.tar.xz
  ```

### 3. 配置服务器地址

使用文本编辑器打开以下文件：

```
内部存储/Download/OpenBachelorC-M/conf/config.json
```

找到 `"host"` 字段，修改为您的自动化服务器 IP 地址：

```json
{
  "host": "127.0.0.1", // 修改为您的服务器地址
  ...
}
```

保存并关闭文件。

---

## 第二阶段：Termux 环境部署

### 1. 初始设置 Termux

1. 打开 Termux 应用
2. 授予存储权限：

   ```bash
   termux-setup-storage
   ```

3. 恢复备份环境：

   ```bash
   termux-restore /sdcard/backup.tar.xz
   ```

   此过程需要一些时间，请等待完成。

---

## 第三阶段：启动自动化

### 情况一：设备已 Root（拥有 Root 权限）

1. 获取 Root 权限：

   ```bash
   su
   ```

2. 重启 Termux 应用
3. 自动启动流程：
   - Termux 启动时会自动执行 `~/storage/downloads/OpenBachelorC-M/start.sh` 脚本
   - 首次运行时可能需要授权 ADB 调试权限，请选择「总是允许」

### 情况二：设备未 Root（无 Root 权限）

需要使用 Android 11 及以上系统自带的「无线调试」功能。

1. **编辑登录脚本**：

   ```bash
   nano $PREFIX/etc/termux-login.sh
   ```

   注释掉自动启动命令（在行首添加 `#`）：

   ```bash
   # sh ~/storage/downloads/OpenBachelorC-M/start.sh
   ```

   按 `Ctrl+X`，输入 `Y` 保存退出。

2. **每次启动的手动操作流程**：

   - 保持 Termux 在分屏或小窗模式
   - 开启开发者选项中的无线调试功能
   - 使用配对码配对设备：

     ```bash
     adb pair localhost:[配对端口]
     ```

     输入显示的六位配对码

   - 连接设备：

     ```bash
     adb connect localhost:[连接端口]
     ```

   - 运行主脚本：

     ```bash
     cd ~/storage/downloads/OpenBachelorC-M/
     sh main.sh
     ```

---

## 常见问题解答 (Q&A)

**Q: 脚本执行失败，提示 `adb: no devices/emulators found`？**

- **A:** ADB 未连接到设备。
  - Root 用户：检查是否授予了 SU 权限和 ADB 调试授权
  - 非 Root 用户：重新进行无线调试的配对和连接

**Q: 提示 Python 模块未找到（如 `No module named 'xxx'`）？**

- **A:** 未正确执行备份恢复操作，请重新执行 `termux-restore /sdcard/backup.tar.xz`

**Q：提示 `permisson denied` ？**
- **A:** 文件的权限不足
    - Root 用户：
      - 1.尝试禁用SELinux： `sudo setenforce 0`
      - 2.赋予文件权限：`cd 文件所在路径 && chmod -R 777`
    - 非 Root 用户：
      - 赋予文件权限：`cd 文件所在路径 && chmod -R 777`

**Q: 如何停止正在运行的脚本？**

- **A:** 退出游戏后，在 Termux 中按 `Ctrl+D` 组合键中断脚本运行

**Q: 非 Root 用户每次都要手动操作吗？**

- **A:** 是的。无线调试的配对码和端口在手机重启或无线调试开关重启后会失效，需要重新配对。可以考虑使用 Android 自动化应用（如「Tasker」或「MacroDroid」）来简化流程。


还有些文件不知道是干什么用的（汗
