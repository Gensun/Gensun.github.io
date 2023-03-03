---
layout: post
title: "IQKeyboardManager break point 1.2"
subtitle: "exception break point"
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.5
tags:
  - IQKeyboardManager
---

### All exception break point is stopping for no reason on simulator

发送breakpoints 在

![1](/img/IQKey/WX20200513-152541.png)

* 先check 是否自定义字体问题或者过时的字体 [all-exception-break-point-is-stopping-for-no-reason-on-simulator](https://stackoverflow.com/questions/27375640/all-exception-break-point-is-stopping-for-no-reason-on-simulator)
* 像图上这种情况。因为OC底层调用的是C++的函数库。我们在加全局异常的时候会自动捕获C++和OC的异常。所以对全局异常进行编辑。只去检测OC的异常就好了。

![2](/img/IQKey/WX20200513-152312.png)

