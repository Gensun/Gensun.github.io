---
layout: post
title: "Failed to install one or more provisioning profiles on the device."
subtitle: ""
author: "Genie"
header-img: "img/post-bg-apple-event-2015.jpg"
header-mask: 0.5
tags:
  - Provisioning Profiles
  - xcode
---

![1](/img/ProvisioningProfiles/WX20200525-095010.png)

> Please ensure the provisioning profile is configured for this device. If not, please try to generate a new profile.

> Failed to install one or more provisioning profiles on the device.

### 最近我经常出现这样的情况，加了新设备，安装profiles总是失败

![2](/img/ProvisioningProfiles/WX20200525-102333.png)

### fixed: 到 ```~/Library/MobileDevice/Provisioning Profiles``` 下去清除profile, 然后到 Signing & Capabilities 下让他自动下载，选择download profile 选择需要的provisioning profiles重新下载

![3](/img/ProvisioningProfiles/WechatIMG185.png)


有问题可以联系[Email](mailto:ep_chengsun@aliyun.com)
