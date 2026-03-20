# 编译指南

本文档介绍如何使用GitHub Actions自动编译微信圆角插件。

## 方法一：使用GitHub Actions自动编译（推荐）

### 步骤1：创建GitHub仓库

1. 访问 [GitHub](https://github.com) 并登录
2. 点击右上角的 "+" 号，选择 "New repository"
3. 填写仓库信息：
   - Repository name: `wechat-corner-tweak`
   - Description: `iOS微信圆角插件`
   - 选择 Public 或 Private（建议Private）
4. 点击 "Create repository"

### 步骤2：上传代码

#### 方法A：使用Git命令行

```bash
# 初始化Git仓库
cd 微信插件圆角
git init

# 添加所有文件
git add .

# 提交更改
git commit -m "Initial commit"

# 添加远程仓库
git remote add origin https://github.com/你的用户名/wechat-corner-tweak.git

# 推送到GitHub
git push -u origin main
```

#### 方法B：使用GitHub网页上传

1. 在新创建的仓库页面，点击 "uploading an existing file"
2. 将项目文件夹中的所有文件拖拽到上传区域
3. 填写提交信息，点击 "Commit changes"

### 步骤3：触发自动编译

#### 自动触发
- 代码推送到main或master分支时，会自动触发编译
- 创建Pull Request时，会自动触发编译

#### 手动触发
1. 进入GitHub仓库页面
2. 点击 "Actions" 标签
3. 选择 "Build iOS Tweak" 工作流
4. 点击 "Run workflow" 按钮
5. 选择分支，点击 "Run workflow"

### 步骤4：下载编译产物

1. 等待编译完成（约2-5分钟）
2. 进入 "Actions" 标签
3. 点击最新的工作流运行记录
4. 在页面底部找到 "Artifacts" 部分
5. 点击 "wechat-corner-tweak" 下载deb包

### 步骤5：安装到设备

#### 方法A：通过SSH安装
```bash
# 将deb包传输到设备
scp packages/*.deb root@你的设备IP:/var/root/

# SSH登录设备
ssh root@你的设备IP

# 安装deb包
dpkg -i /var/root/*.deb

# 重装微信（可选）
killall WeChat
```

#### 方法B：通过Filza安装
1. 将deb包传输到设备（AirDrop、iCloud等）
2. 使用Filza打开deb包
3. 点击右上角的安装按钮
4. 重启SpringBoard或微信

## 方法二：本地编译（需要macOS）

### 前置要求
- macOS 10.15或更高版本
- Xcode Command Line Tools
- Homebrew

### 安装Theos

```bash
# 安装Homebrew（如果没有）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装Theos
brew install theos
```

### 编译插件

```bash
cd 微信插件圆角

# 清理旧的编译文件
make clean

# 编译打包
make package

# 安装到连接的设备
make install
```

### 编译产物位置
编译完成后，deb包位于 `packages/` 目录下。

## 方法三：在越狱设备上编译

### 前置要求
- 已越狱的iOS设备
- NewTerm或其他终端应用
- 网络连接

### 安装Theos

```bash
# 添加Theos源
echo "deb https://repo.theos.dev/ ./" | tee -a /etc/apt/sources.list.d/theos.list

# 更新软件源
apt-get update

# 安装Theos
apt-get install theos
```

### 编译插件

```bash
# 将项目文件传输到设备
# 然后在设备上执行：

cd /path/to/wechat-corner-tweak

# 编译打包
make clean
make package

# 安装
make install
```

## 发布新版本

### 自动发布

1. 创建并推送标签：
```bash
git tag v1.0.0
git push origin v1.0.0
```

2. GitHub Actions会自动：
   - 编译插件
   - 创建GitHub Release
   - 上传deb包到Release页面

### 手动发布

1. 访问仓库的 "Releases" 页面
2. 点击 "Draft a new release"
3. 填写版本号和发布说明
4. 上传编译好的deb包
5. 点击 "Publish release"

## 常见问题

### Q: 编译失败怎么办？
A: 检查以下内容：
- Makefile配置是否正确
- Theos是否正确安装
- 代码语法是否有错误

### Q: 如何查看编译日志？
A: 
1. 进入GitHub仓库的Actions页面
2. 点击具体的工作流运行记录
3. 查看详细的编译日志

### Q: 如何修改编译配置？
A: 编辑 `.github/workflows/build.yml` 文件，修改编译参数。

### Q: 支持哪些iOS版本？
A: 支持iOS 7.0及以上版本，兼容最新的iOS版本。

### Q: 需要越狱吗？
A: 是的，此插件只能在越狱的iOS设备上运行。

## 技术支持

如有问题，请：
1. 查看GitHub Issues
2. 检查编译日志
3. 参考Theos官方文档

## 许可证

本项目仅供学习交流使用。