# 微信圆角插件 (iOS)

一个为iOS微信客户端添加圆角效果的越狱插件，支持自定义各种UI组件的圆角半径和边框。

## 功能特性

- **总开关控制**：一键启用/禁用圆角效果
- **边框控制**：可选择是否显示边框
- **多种组件支持**：
  - 头像圆角
  - 输入框圆角
  - 拍一拍圆角
  - 消息时间圆角
  - 按钮圆角
  - 表情圆角
  - 层栏圆角
  - 列表圆角
- **实时预览**：调整设置后立即生效
- **自定义参数**：每个组件可独立设置圆角半径和边框宽度

## 系统要求

- iOS 7.0 或更高版本
- 已越狱的iOS设备
- Cydia或Sileo包管理器
- Theos开发环境

## 安装方法

### 方法一：通过Cydia/Sileo安装

1. 将编译好的deb包添加到你的软件源
2. 在Cydia/Sileo中搜索"微信圆角"
3. 点击安装

### 方法二：手动安装

1. 编译插件：
   ```bash
   make clean
   make package
   make install
   ```

2. 或者手动安装deb包：
   ```bash
   dpkg -i com.example.wechatcorner_1.0.0_iphoneos-arm.deb
   ```

## 使用说明

1. 安装插件后，在设置应用中找到"微信圆角"选项
2. 打开总开关启用圆角效果
3. 根据需要调整各个组件的圆角半径和边框宽度
4. 设置会立即生效，无需重启微信

## 开发环境搭建

### 安装Theos

```bash
# 在越狱设备上安装Theos
apt-get install theos
```

### 编译插件

```bash
# 克隆或下载项目到设备
cd 微信插件圆角

# 编译并安装
make clean
make package
make install
```

## 项目结构

```
微信插件圆角/
├── Makefile                    # 主Makefile
├── control                     # 包管理信息
├── Tweak.x                     # 主要Hook逻辑
├── wechatcornerprefs/          # 设置界面
│   ├── Makefile               # 设置界面Makefile
│   ├── Root.plist             # 设置界面配置
│   ├── entry.plist            # 设置入口配置
│   └── WeChatCornerPrefsListController.mm
└── README.md                   # 说明文档
```

## 技术实现

- **Hook框架**：使用Theos的Logos语法
- **UI修改**：通过Hook UIView、UIImageView等组件的didMoveToWindow方法
- **设置存储**：使用NSUserDefaults存储用户配置
- **实时更新**：通过CFNotificationCenter实现设置变更通知

## 注意事项

1. 此插件仅适用于已越狱的iOS设备
2. 需要微信客户端运行在越狱环境中
3. 插件可能会影响微信的性能，建议在较新设备上使用
4. 使用前请备份重要数据

## 兼容性

- 支持iOS 7.0及以上版本
- 兼容最新版本的微信客户端
- 支持iPhone和iPad设备

## 许可证

本项目仅供学习交流使用，请勿用于商业用途。

## 作者

筱茨

## 更新日志

### v1.0.0 (2026-03-20)
- 初始版本发布
- 支持8种UI组件的圆角设置
- 添加边框控制功能
- 实现实时预览功能

## 问题反馈

如有问题或建议，请联系作者。