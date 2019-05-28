---
layout: post
title: "git rebase 优化多commit"
subtitle: "git rebase"
author: "Genie"
header-img: "img/post-bg-kuaidi.jpg"
header-mask: 0.5
tags:
  - git rebase
  - 多条commit合并
---

在开发中我们用git管理代码，往往我们在修复一个bug，或者开发一个feature时候，会产生多次提交，如果是覆盖提交还好，如果只是来回重复提交一个bug修复及小功能的优化，这个时候你的branch的commit会产生多条无用的或者不必要的comment，此时我们需要用到rebase，合并提交，优化多条commit

1. 首先在sourcetree设置中开启强制推
![1](/img/git/1@2x.png)
2. 选择某个你最想回归的commit
![2](/img/git/3@2x.png)
3. soft rebase 你的commit
![3](/img/git/4@2x.png)
4. 勾选 强制 push，push
![4](/img/git/1@2x.png)

`如果多条commit 还没有push origin的话，您不需要开启强制push，only本地rebase之后push origin
`

有问题可以联系[Email](mailto:ep_chengsun@aliyun.com)
