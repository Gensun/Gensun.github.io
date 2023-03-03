---
layout: post
title: "NSRegularExpression"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  swift
---

#### 常规方式
```

struct RegexHelper {
    let regex: NSRegularExpression

    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern,
                                        options: .caseInsensitive)
    }

    func match(input: String) -> Bool {
        let matches = regex.matches(in: input,
                                    options: [],
                                    range: NSMakeRange(0, input.utf16.count))
        return matches.count > 0
    }
}

let mailPattern =
    "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"

let matcher: RegexHelper
do {
    matcher = try RegexHelper(mailPattern)
}

let maybeMailAddress = "ep_chengsun@aliyun.com"

if matcher.match(input: maybeMailAddress) {
    print("有效的邮箱地址")
}

```

#### 运算符

```
precedencegroup Precedence {
    higherThan: AdditionPrecedence // 优先级,比加法运算高
//    lowerThan: MultiplicationPrecedence // 优先级, 比乘法运算低
    associativity: none // 结合方向:left, right or none
    assignment: false // true=赋值运算符,false=非赋值运算符
}

infix operator =~: Precedence
func =~ (lhs: String, rhs: String) -> Bool {
    do {
        return try RegexHelper(rhs).match(input: lhs)
    } catch _ {
        return false
    }
}

if "ep_chengsun@aliyun.com" =~
    "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$" {
    print("有效的邮箱地址")
}


```
