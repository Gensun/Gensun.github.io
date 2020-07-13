---
layout: post
title: "New in swift 4.2"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  swift 4.2
---

# Bool.toggle

[反转](https://www.floatingraft.com/2020/06/18/toggle-%E5%8F%8D%E8%BD%AC/)

# Sequence and Collection algorithms
	> 序列和收集算法
	
## 序列中添加了allSatisfy算法，allSatisfy 很好地补充了 `where` 

> 当且仅当序列中的所有元素都满足给定谓词时，allSatisfy才返回true

```
let digits = 0...9

let areAllSmallerThanTen = digits.allSatisfy { $0 < 10 }
areAllSmallerThanTen //true

let areAllEven = digits.allSatisfy { $0 % 2 == 0 }
areAllEven //false
```

## last(where:), lastIndex(where:), and lastIndex(of:)

```
let lastEvenDigit = digits.last { $0 % 2 == 0 }
lastEvenDigit //8

let text = "Vamos a la playa"

let lastWordBreak = text.lastIndex(where: { $0 == " " })
let lastWord = lastWordBreak.map { text[text.index(after: $0)...] }
lastWord //playa

text.lastIndex(of: " ") == lastWordBreak

```

## Rename index(of:) and index(where:) to firstIndex(of:) and firstIndex(where:)

```
let firstWordBreak = text.firstIndex(where: { $0 == " " })
let firstWord = firstWordBreak.map { text[..<$0] }
firstWord
```

## removeAll(where:)

```
var numbers = Array(1...10)
numbers.removeAll(where : { $0 % 2 == 0 })
numbers //[1,3,5,7,9]

```

# Enumerating enum cases

通过 `CaseIterable`自动为枚举生成allCases属性

```
enum Terrain: CaseIterable {
    case water
    case forest
    case desert
    case road
}

Terrain.allCases
Terrain.allCases.count
print(Terrain.water) //water
```

```

extension Optional: CaseIterable where Wrapped: CaseIterable {
    public typealias AllCases = [Wrapped?]
    public static var allCases: AllCases {
        return Wrapped.allCases.map { $0 } + [nil]
    }
}
// ? 是代表在访问可选Terrain类型的成员
Terrain?.allCases //[water, forest, desert, road,nil]
Terrain?.allCases.count //5

Terrain.allCases //[water, forest, desert, road]
Terrain.allCases.count //4

```

# Random numbers
	
## `random(in:)` 该方法返回给定范围内的随机数

```

Int.random(in: 1...1000)
UInt8.random(in: .min ... .max)
Double.random(in: 0..<1)
```

通过投掷硬币案例分析

```
func coinToss(count tossCount: Int) -> (heads: Int, tails: Int) {
    var tally = (heads: 0, tails: 0)
    for _ in 0..<tossCount {
        let isHeads = Bool.random()
        if isHeads {
            tally.heads += 1
        } else {
            tally.tails += 1
        }
    }
    return tally
}

let (heads, tails) = coinToss(count: 100)
print("100 coin tosses — heads: \(heads), tails: \(tails)")
```
## 随机元素

```
let emotions = "😀😂😊😍🤪😎😩😭😡"
let randomEmotion = emotions.randomElement()!
```

`shuffled` 洗牌 ,就是随机洗乱一组数据

```
let numbers = 1...10
let shuffled = numbers.shuffled()
```

## 自定义随机数生成器

标准库默认带有 `SystemRandomNumberGenerator `  对于大多数简单随机数已经够用，但是也可以通过extension `RandomNumberGenerator `  来实现自己的随机数生成器

```
struct MyRandomNumberGenerator: RandomNumberGenerator {
    var base = SystemRandomNumberGenerator()
    mutating func next() -> UInt64 {
        return base.next() 
    }
}

var customRNG = MyRandomNumberGenerator()
Int.random(in: 0...100, using: &customRNG)
```

## 扩展自己的类型,产生随机数

```
enum Suit: String, CaseIterable {
    case diamonds = "♦"
    case clubs = "♣"
    case hearts = "♥"
    case spades = "♠"

    static func random<T: RandomNumberGenerator>(using generator: inout T) -> Suit {
        // Using CaseIterable for the implementation
        return allCases.randomElement(using: &generator)!

    }

    static func random() -> Suit {
        var rng = SystemRandomNumberGenerator()
        return Suit.random(using: &rng)
    }
}

let randomSuit = Suit.random()
randomSuit.rawValue
```

# Hashable redesign


# Conditional conformance enhancements

# Removal of CountableRange and CountableClosedRange

```
let integerRange: Range = 0..<5
// We can map over a range of integers because it's a Collection
let integerStrings = integerRange.map { String($0) }
integerStrings

// 这是错误的使用，当使用map  error!
let floatRange: Range = 0.0..<5.0
```

# Dynamic member lookup

## 动态查找成员

```
import Darwin
@dynamicMemberLookup
struct Environment {
    subscript(dynamicMember name: String) -> String? {
        get {
            guard let value = getenv(name) else { return "undefined" }
            return String(validatingUTF8: value)
        }
        nonmutating set {
            if let value = newValue {
                setenv(name, value, 1)
            } else {
                unsetenv(name)
            }
        }
    }
}

let environment = Environment()
environment.USER
environment.HOME
environment.PATH
environment.MY_VAR = "Hello world"
environment.MY_VAR

@dynamicMemberLookup
struct Person {
    subscript(dynamicMember member: String) -> String {
        let properties = ["nickname": "Zhuo", "city": "Hangzhou"]
        return properties[member, default: "undefined"]
    }
}

//执行以下代码
let p = Person()
print(p.city)
print(p.nickname)
print(p.name)

```

# Implicitly unwrapped optionals

# guard let self = self 
> 目前无法使用 

 [参考](https://www.floatingraft.com/2020/06/17/%E4%BB%80%E4%B9%88%E6%97%B6%E5%80%99%E4%BD%BF%E7%94%A8-unowned-weak/)

# #error and #warning

# #if compiler version directive

# MemoryLayout.offset(of:)

# @inlinable

SE-0193引入了两个新的属性：`@inlinable`和 `@usableFromInline`

这些对于应用程序代码来说是不必须的，开发者可以将一些公共功能注释为`@inlinable`。这给编译器提供了优化跨模块边界的泛型代码的选项。

例如，提供一组集合算法的库可以将这些方法标记为`@inlinable`，以允许编译器将使用这些算法的客户端代码专门化为在构建库时未知的类型。

```
// Inside CollectionAlgorithms module:
extension Sequence where Element: Equatable {
    /// Returns `true` iff all elements in the sequence are equal.
    @inlinable
    public func allEqual() -> Bool {
        var iterator = makeIterator()
        guard let first = iterator.next() else {
            return true
        }
        while let next = iterator.next() {
            if first != next {
                return false
            }
        }
        return true
    }
}

[1,1,1,1,1].allEqual()
Array(repeating: 42, count: 1000).allEqual()
[1,1,2,1,1].allEqual()


```

在使函数不能链接之前仔细考虑。使用@inlinable有效地使库的公共接口的功能部分成为主体。如果您稍后更改实现（例如修复错误），则针对旧版本编译的二进制文件可能继续使用旧的（内联）代码，甚至是旧的和新的混合（因为@inlinable仅是提示；优化器决定每个调用站点是否要内嵌代码）。

因为可以将可链接函数发送到客户端二进制，所以不允许引用客户端二进制文件不可见的声明。您可以使用@usableFromInline在你的“ABI-public”库中进行某些内部声明，允许它们在可链接函数中使用。

# Immutable withUnsafePointer