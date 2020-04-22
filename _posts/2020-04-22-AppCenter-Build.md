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

![2021941856797225527](/img/AppCenter/Build/2021941856797225527.png)

## Accounts
> 在sourcetree 里面添加bitbucket帐号

选择OAuth, 按照提示步骤操作完成即可，然后你就可以对仓库做操作了

![1218831768245594514_1541586338698](/img/AppCenter/Build/1218831768245594514.png)

## 创建Branch
> 我们在bitbucket上面创建一个或者倒入一个代码仓库

![5004901999519636166](/img/AppCenter/Build/5004901999519636166.png)

## Connect to repo (Bitbucket)
> 通过Appcenter，点击左侧build

![8901641489103422840](/img/AppCenter/Build/8901641489103422840.png)

> 链接仓库,选择需要操作的仓库

![8216014132400956547](/img/AppCenter/Build/8216014132400956547.png)

## Configure Build
> 一定不要文件及类名用中文，不然会不识别 .
``` " We couldn’t find any iOS Objective-C/Swift projects in your branch. " ```

![2582867336491888894](/img/AppCenter/Build/2582867336491888894.png)

> 如果pod 代码，需要 更高scheme为workspace 为 share

![127996522893882839](/img/AppCenter/Build/127996522893882839.png)

按照要求配置

## Build Now
> 当build成功结束，你可以在Appcenter 左侧Distribute releases里面看到你build 的project。当然你也可以随时cancel build，对于test，我们没有提供资金支持，所以放弃，so人肉test，也是很香的。

![8866619888341179554](/img/AppCenter/Build/8866619888341179554.png)

## Release (TestFlight)
> 当测试完成需要发testflight，直接操作release到store里面

![8150647333119693086](/img/AppCenter/Build/8150647333119693086.png)

![5386010588918464033](/img/AppCenter/Build/5386010588918464033.png)

> 这时候测试可以通过testflight测试

![5933813851902421983](/img/AppCenter/Build/5933813851902421983.png)
