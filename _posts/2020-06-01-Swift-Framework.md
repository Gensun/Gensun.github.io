---
layout: post
title: "Framework"
subtitle: "swift制作framework"
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
	-  swift
	-  Framework
---

# 当下
1. Apple 为了 iOS 平台的安全性考虑，是 _不允许动态链接_  非系统的框架的。
2.  在工作中我们使用静态库是以 .a 的二进制文件加上一些 .h 的头文件进行定义的形式提供的，这样的静态库在使用时比较麻烦，我们除了将其添加到项目和配置链接外，还需要进行指明头文件位置等工作
3. Apple 自己的框架都是 .framework 为后缀的动态框架，我们使用这些框架的时候只需要在 target 配置时进行指明就可以，非常方便。
 
# 选择
  ![1](/img/Framwwork/WX20200610-112706.png)
首先通过新建菜单的 Framework & Library 创建一个 Cocoa Touch Framework 项目，命名为 HelloKit，然后添加一个 Swift 文件以及随便一些什么内容，比如：

```
public class Hello {
    public class func test() {
        print("Hello world!")
    }
}
```

注意我们在这里添加了 public 声明，这是因为我们的目的是在当前 module 之外使用这些代码。将运行目标选择为任一 iOS 模拟器，然后使用 Shift + Cmd + I 进行 Profiling 编译。我们可以在项目的生成的数据文件夹中 (使用 Window 菜单的 Organizer 可以找到对应项目的该文件夹位置) 的 /Build/Products/Release-iphonesimulator 里找到 HelloKit.framework。

如果直接使用 Cmd + B 进行编译的话我们得到的会是一个 Debug 版本的结果，在绝大多数情况下这应该不是我们想要的，除非你是需要用来进行调试。

然后新建一个项目来看看如何使用这个框架吧。建立新的 Xcode 项目，语言当然是选择为 Swift，然后将刚才的 HelloKit.framework 拖到 Xcode 项目中就可以了。我们最好勾选上 Copy items if needed，这样原来的框架的改动就不会影响到我们的项目了。

接下来，我们在需要使用这个框架的地方加上对框架的导入和调用。为了简单，我们就在 ViewController.swift 的 viewDidLoad 方法中 call test：

```
import HelloKit
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Hello.test()
    }
}
```
> 当然，别忘记在顶部加上 import HelloKit 来导入框架。

这时候点击运行会报出这样的错误
```
dyld: Library not loaded: @rpath/HelloKit.framework/HelloKit
  Referenced from: /Users/cheng/Library/Developer/CoreSimulator/Devices/F0080C32-BF67-4BC6-A165-A2B60B2D76E1/data/Containers/Bundle/Application/BA29BFD0-5423-45E2-A359-AF087EE226A0/HelloFramework.app/HelloFramework
  Reason: image not found
(lldb) 
```
解决方案：
> [https://stackoverflow.com/questions/24993752/os-x-framework-library-not-loaded-image-not-found](https://stackoverflow.com/questions/24993752/os-x-framework-library-not-loaded-image-not-found)

![2](/img/Framkework/WX20200610-113136.png)

我们刚才编译的时候只做了模拟器的版本，如果你尝试一下在 app 项目中将目标切换为真机的话，会发现根本无法编译，这是由于模拟器和实际设备所使用的架构不同导致的。我们需要回到框架项目中，将编译目标切换为 iOS Device，然后再次使用 Shift + Cmd + I 进行编译。这时我们可以在 Release-iphoneos 文件夹下得到真实设备可以使用的框架。最后我们通过 lipo 命令将适用于多个架构的二进制文件进行合并，以得到可以在模拟器和实际设备上通用的二进制文件：

```
lipo -create -output HelloKit \
       Release-iphoneos/HelloKit.framework/HelloKit \
       Release-iphonesimulator/HelloKit.framework/HelloKit
```
然后将得到的包含各架构的新的 HelloKit 文件复制到刚才的模拟器版本的 HelloKit.framework 中 (没错其实它是个文件夹)，覆盖原来的版本。最后再将 Release-iphoneos 中的框架文件里的 /Modules/HelloKit.swiftmodule 下的 arm.swiftmodule 和 arm64.swiftmodule 两个文件复制到模拟器版本的对应的文件夹下 (这个文件夹下最终应该会有 i386，x86_64，arm 和 arm64 四个版本的 module 文件)。我们现在就得到了一个通吃模拟器和实际设备的框架了，用这个框架替换掉刚才我们复制到 app 项目中的那个，app 应该就可以同时在模拟器和设备上使用这个自制框架了。


[github code](https://github.com/Gensun/Hello-Framework)