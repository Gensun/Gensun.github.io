_posts---
layout: post
title: "iOS 代码格式化"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.6
tags:
  -  XCFormat
  -  clang-format
  -  xcode

---

## Xcode 如何实现代码格式化

方案分2种：

1. App Store 下载XCFormat
2. ClangFormat

### 重点来描述下ClangFormat在Xcode中如何实现快捷化

>简述：
>
> * ClangFormat 是一个规范代码的工具
> * ClangFormat 支持的语言有：C/C++/Java/JavaScript/Objective-C/Protobuf/C#
> * ClangFormat 支持的规范有：LLVM，Google，Chromium，Mozilla 和 WebKit

#### 设备：

1. 安装 
 **M1 Mac Pro** `arch -arm64 brew install clang-format`
 **intel** ```brew install clang-format```

2. 查询路径和版本
	* 	检测安装是否成功，查看版本 `clang-format --version`
	*  	执行 `which clang-format` copy下路径，后续使用
3. 创建format规则

	下载 [.clang-format](https://raw.githubusercontent.com/Gensun/Gensun.github.io/master/img/code-format/clang-format)，放到用户路径下,重命名
	`. clang-format `
 
 	
4. 创建机器人
	 打开**Automator**，创建`Quick Action`， 在 `library` 下选择 `Run shell Script`
	 
	![1](/img/code-format/WX20211019-153013@2x.png)
	
	* 	workflow in xcode.app
	*   勾选Output replaces selected text

	*   在shell script 下写入 ```export PATH=/opt/homebrew/bin:$PATH
clang-format```
	*   最后保存，命名随意 eg. `xcode_format`

到此为止，可在Xcode文件中右键点击 Services->你命名的shell，便可实现format code

### 那如何实现快捷键来format code
在system preferences -> keyboard->Shortcuts->App Shortcuts 创建一个 `xcode_format` 快捷键
	![2](/img/code-format/WX20211019-152951@2x.png)
	![3](/img/code-format/WX20230104-180328@2x.png)


