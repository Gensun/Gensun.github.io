---
layout: post
title: "@ autoclosure"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  autoclosure
  -  swift
---

```
func logIfTrue(predicate: () -> Bool) {
    if predicate() {
        print("true")
    }
}

logIfTrue { () -> Bool in
    2 > 1
}

logIfTrue { 2 > 1 }

func logIfTrueTwo(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("true")
    }
}

logIfTrueTwo(2 < 1)

```

> 和java中lambda很相似，so 语言是相通的

使用 `@ autoclosure` 和不使用的区别：如果不使用autoclosure，那当我们调用时，我们就必须准备好一个默认值传入到这个方法中，常规情况下无恙，但是当进行大量计算的情况下就浪费性能。

```
func getName() -> String {
    print(#function)
    return "DKJone"
}

func goodAfternoon(afternoon: Bool, who: String) {
    if afternoon {
        print("Good afternoon, \(who)")
    }
}

func goodMorning(morning: Bool, who: @autoclosure () -> String) {
    if morning {
        print("Good morning, \(who())")
    }
}

print("------goodAfternoon(afternoon: true, who: getName())-------")
goodAfternoon(afternoon: true, who: getName())
print("------goodAfternoon(afternoon: false, who: getName())-------")
goodAfternoon(afternoon: false, who: getName())
print("------goodMorning(morning: false, who: getName())-------")
goodMorning(morning: false, who: getName())

/**
------goodAfternoon(afternoon: true, who: getName())-------
getName()
Good afternoon, DKJone
------goodAfternoon(afternoon: false, who: getName())-------
getName()
------goodMorning(morning: false, who: getName())-------
*/
```
