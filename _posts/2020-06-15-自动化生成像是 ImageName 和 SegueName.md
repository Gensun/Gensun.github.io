---
layout: post
title: "自动化生成像是 ImageName 和 SegueName"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  swift
---

在 Cocoa 框架中还有不少类似的用字符串来指定资源的使用方式。这类方法其实是存在隐患的，如果资源的名称发生了改变的话，你必须在代码中作出相应的改变

```
enum ImageName: String {
    case MyImage = "my_image"
}

enum SegueName: String {
    case MySegue = "my_segue"
}

extension UIImage {
    convenience init!(imageName: ImageName) {
        self.init(named: imageName.rawValue)
    }
}

extension UIViewController {
    func performSegueWithSegueName(segueName: SegueName, sender: AnyObject?) {
        performSegueWithIdentifier(segueName.rawValue, sender: sender)
    }
}
```

```
let image = UIImage(imageName: .MyImage)

performSegueWithSegueName(.MySegue, sender: self)

```