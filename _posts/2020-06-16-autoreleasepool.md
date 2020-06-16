---
layout: post
title: "autoreleasepool"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  
---

在oc 中 `@ autoreleasepool `

```
@ autoreleasepool {
}
```

在swift中 `autoreleasepool ` 使用

```
autoreleasepool(invoking: {
    for i in 0 ... 1 {
        print(i)
    }
})
```