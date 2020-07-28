---
layout: post
title: "new in swift 5.2"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  swift
---

**proposals**

## [SE-0249 Key Path Expressions as Functions
](https://github.com/apple/swift-evolution/blob/master/proposals/0249-key-path-literal-function-expressions.md)

```
struct User {
    let email: String
    let isAdmin: Bool
}

let users = [User(email: "1", isAdmin: true), User(email: "11", isAdmin: false), User(email: "12", isAdmin: true)]
users.map { $0.email }.forEach({ print($0) })
users.compactMap({ $0.email }).forEach({ print($0) })
users.filter { $0.isAdmin }.forEach({ print($0) })
users.map(\.email)
users.filter(\.isAdmin)
users.map { $0[keyPath: \User.email] }

let f1: (User) -> String = \User.email
users.map(f1)

let f2: (User) -> String = \.email
users.map(f2)


let f4 = \.email as (User) -> String
users.map(f4)

// Multi-segment key paths
users.map(\.email.count)

prefix operator ^

prefix func ^ <Root, Value>(keyPath: KeyPath<Root, Value>) -> (Root) -> Value {
  return { root in root[keyPath: keyPath] }
}

users.map(^\.email)

users.filter(^\.isAdmin)

```

## [SE-0253 Callable values of user-defined nominal types
](https://github.com/apple/swift-evolution/blob/master/proposals/0253-callable.md)


## 新版大幅度提升了 Swift 编译器的质量，以及错误提示的精确度。

```
enum E { case one, two }

func check(e: E) {
  if e != .three {
    print("okay")
  }
}
//Swift 5.1 中，可能会对这个错误提示比较困惑：

error: binary operator '!=' cannot be applied to operands of type 'E' and '_'
  if e != .three {
     ~ ^  ~~~~~~
//在 Swift 5.2 中，将可以立马找到问题原因：

error: type 'E' has no member 'three'
  if e != .three {
          ~^~~~~
```

## 相比 Xcode 11.3.1，code completion 速度大概提升了 1.2 倍到 1.6 倍。

## 现在可以提供隐式成员名字的显示，比如 dictionary 和 三元表达式。

```
struct ghjk {
    enum ConfigKey {
        case A, B
    }

    var flag: Bool

    var configDictionary: ConfigKey {
        return flag ? .A : .B
    }
}
let t = ghjk.init(flag: false)
let dict = t.configDictionary
```

## Swift 编译器支持两种模式：

* Whole Module（主要用于 Release 构建）
* Incremental（主要用于 Debug 构建）

Xcode 中可以看到如下 build 设置：

![1](/img/swiftOptimize/WX20200728-112836.png)
