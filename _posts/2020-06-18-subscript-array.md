---
layout: post
title: "subscript"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  swift
---

在一个数组内，我想取出 index 为 0, 2, 3 的元素

```
extension Array {
    subscript(input: [Int]) -> Array<Int> {
        get {
            var result = Array<Int>()
            for i in input {
                assert(i < self.count, "index out of range")
                result.append(self[i] as! Int)
            }
            return result
        }
        set {
            for (index, i) in input.enumerated() {
                assert(i < self.count, "index out of range")
                self[i] = newValue[index] as! Element
            }
        }
    }
}

var arr = [1, 2, 3, 4, 5]
arr[[0, 2, 3]]
arr[[1, 2, 3]] = [10, 11, 12] //可直接赋值

```

可变参数函数方式

```
func sum(input: Int ...) -> Int {
    return input.reduce(0, +)
}
```

```
func myFunc(numbers: Int..., string: String) {
    numbers.forEach {
        for i in 0..<$0 {
            print("\(i + 1): \(string)")
        }
    }
}

myFunc(1, 2, 3, string: "hello")
```