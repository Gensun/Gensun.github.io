---
layout: post
title: "makeObjectsPerformSelector"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  
---

你如何去把一个view的所有subview清空？

1. `makeObjectsPerformSelector`

```   
 [[self.view subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
```

2. `for in`
3. `NSArray` 的 `enumerator`