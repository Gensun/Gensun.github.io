---
layout: post
title: "Perfect-HTTPServer"
subtitle: "如何用swift5开发server服务器"
author: "Genie"
header-img: "img/swiftServer/prefect.jpeg"
header-mask: 0.7
tags:
  - PrefectServer
  - swift5
  - swift服务端开发
---

# Perfect.org
[官方网站](https://www.perfect.org)

[文档详情: 官方中文文档](https://www.perfect.org/docs/index_zh_CN.html)

 > Perfect是一组完整、强大的工具箱、软件框架体系和Web应用服务器，可以在Linux、iOS和macOS (OS X)上使用。该软件体系为Swift工程师量身定制了一整套用于开发轻量、易维护、规模可扩展的Web应用及其它REST服务的解决方案，这样Swift工程师就可以实现同时在服务器和客户端上采用同一种语言开发软件项目。

构建初学者项目
以下将克隆并构建一个空的启动项目。它将启动将在您的计算机上的端口8181上运行的本地服务器：

```
git clone https://github.com/PerfectlySoft/PerfectTemplate.git
cd PerfectTemplate
swift build
.build/debug/PerfectTemplate
```
您应该看到以下输出：

```
[INFO] Starting HTTP server localhost on 0.0.0.0:8181
``` 

服务器现在正在运行并等待连接。访问[http://localhost:8181/](http://localhost:8181/)以查看问候语。点击“control-c”终止服务器。

您可以查看[PerfectTemplate](https://github.com/PerfectlySoft/PerfectTemplate)的完整源代码。

# 配置Package
##  clone下来的仓库，找到package修改为下
```
import PackageDescription

let package = Package(
    name: "Server",
    products: [
        .executable(name: "Server", targets: ["Server"])
    ],
    dependencies: [
     	//http 服务器
        .package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0"),
        //MySql
        .package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git",from: "3.4.0"), 
        //Mustache模版语言
        .package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", from: "3.0.0") 
    ],
    targets: [
        .target(name: "Server", dependencies: ["PerfectHTTPServer","PerfectMySQL","PerfectMustache"])
    ]
)
```

1. name 和 target 可以按照自己的意愿修改，⚠️注意的是MySql，后面会讲到
2. 删除掉原来的 ```PerfectTemplate.xcodeproj```, 在终端中输入以下内容：```
swift package generate-xcodeproj
``` 打开生成的文件，确保您已选择可执行目标并将其选中以在“我的Mac”上运行。您现在可以直接在Xcode中运行和调试服务器。

> 在Xcode中
> 
> Swift Package Manager（SPM）可以生成一个Xcode项目 

### 处理报错
这时候你会发现很多报错my_bool ,== 之类的几十种报错，不要慌主要原因是Mysql版本过高导致的，
在终端 mysql --version 查询MySQL版本。

``` mysql  Ver 8.0.13 for osx10.14 on x86_64 (Homebrew) ```

解决办法：
卸载MySQL，然后重新安装：终端输入以下命令：

``` brew uninstall mysql ```

``` brew install mysql@5.7 ```

``` brew install mysql@5.7 && brew link mysql@5.7 --force```

然在查询MySQL版本确认

``` mysql  Ver 14.14 Distrib 5.7.25, for osx10.14 (x86_64) using  EditLine wrapper ```

然后重新开启就没有报错了，注意勾选Mac运行


#	MySQL

![MySQL](/img/swiftServer/MySql.png)

#### 安装数据库工具 

### [Navicat Premium](http://xclient.info/s/navicat-premium.html)
### [SQLPro for MySql](https://itunes.apple.com/cn/app/sqlpro-for-mysql/id899174769?l=en&mt=12) 我用的这个

## 安装MySQL

1. 通过brew 安装``` brew install mysql ```
2. 手动安装MySQL：[https://dev.mysql.com/downloads/mysql/](https://dev.mysql.com/downloads/mysql/) 推荐

## 配置

```
#开启MySQL服务
mysql.server start
#初始化MySQL配置向导
mysql_secure_installation

```
## 建表
建立连接 ![建立连接](/img/swiftServer/WX20190417-193754@2x.png)

建DB建表 ![建表](/img/swiftServer/WX20190417-193555@2x.png)

# 搭建HTTP服务器


# demo
### 无MySQl数据库版 实现login / profile / photo传输
#### [demo](https://github.com/Gensun/PerfectHttp_NODB.git)

有问题可以联系[Email](mailto:ep_chengsun@aliyum.com)
