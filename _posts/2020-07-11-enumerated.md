---
layout: post
title: "和OC `enumerateObjectsUsingBlock `说再见"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  swift
---

enumerateObjectsUsingBlock 在swift中已不再能使用

我们能通过更好的方式来实现 `enumerated()`

```
for (idx, num) in [1,2,3,4,5].enumerated() {
}
```
