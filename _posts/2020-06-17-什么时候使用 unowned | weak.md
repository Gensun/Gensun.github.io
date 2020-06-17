---
layout: post
title: "什么时候使用 unowned | weak"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  swift
---

我们使用unowned 和weak 主要是解决循环引用

```
lazy var printName: ()->() = {
    [weak self] in
    if let strongSelf = self {
        print("The name is \(strongSelf.name)")
    }
}
```

> 如果我们可以确定在整个过程中 self 不会被释放的话，我们可以将上面的 weak 改为 unowned，这样就不再需要 strongSelf 的判断。但是如果在过程中 self 被释放了而 printName 这个闭包没有被释放的话 (比如 生成 Person 后，某个外部变量持有了 printName，随后这个 Persone 对象被释放了，但是 printName 已然存在并可能被调用)，使用 unowned 将造成崩溃。在这里我们需要根据实际的需求来决定是使用 weak 还是 unowned。
>
>

