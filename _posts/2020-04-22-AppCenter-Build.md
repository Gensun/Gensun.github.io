---
layout: post
title: "AppCenter Build"
subtitle: ""
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.5
tags:
  - AppCenter
  - Auto Build for iOS
---

# AppCenter
# Build for iOS
### First Lab
> BitBucket 和GitHub，gitlab 一样的代码仓库
 
### clone
> 我们选择在Sourcetree 里link，在SourceTree图形界面工具里对代码管理是优质的选择

![1](/img/AppCenter/Build/202194.png)

## Accounts
> 在sourcetree 里面添加bitbucket帐号

选择OAuth, 按照提示步骤操作完成即可，然后你就可以对仓库做操作了


![2](/img/AppCenter/Build/121883.png)

## 创建Branch
> 我们在bitbucket上面创建一个或者倒入一个代码仓库

![3](/img/AppCenter/Build/500490.png)

## Connect to repo (Bitbucket)
> 通过Appcenter，点击左侧build

![4](/img/AppCenter/Build/890164.png)

> 链接仓库,选择需要操作的仓库

![5](/img/AppCenter/Build/821601.png)

## Configure Build
> 一定不要文件及类名用中文，不然会不识别 .
``` " We couldn’t find any iOS Objective-C/Swift projects in your branch. " ```

![6](/img/AppCenter/Build/258286.png)

> 如果pod 代码，需要 更高scheme为workspace 为 share

![7](/img/AppCenter/Build/127996.png)

按照要求配置

## Build Now
> 当build成功结束，你可以在Appcenter 左侧Distribute releases里面看到你build 的project。当然你也可以随时cancel build，对于test，我们没有提供资金支持，所以放弃，so人肉test，也是很香的。

![8](/img/AppCenter/Build/886661.png)

## Release (TestFlight)
> 当测试完成需要发testflight，直接操作release到store里面

![9](/img/AppCenter/Build/815064.png)

![10](/img/AppCenter/Build/538601.png)

> 这时候测试可以通过testflight测试

![11](/img/AppCenter/Build/5933813851902421983.png)
