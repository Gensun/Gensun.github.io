---
layout: post
title: "MemoryLayout"
subtitle: "写出内存最优的struct"
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  swift
  -  MemoryLayout
---

**Swift类型在内存中处理时要考虑三个属性：size，stride和alignment**

MemoryLayout 是个枚举 一种类型的内存布局，描述其大小、步长和对齐方式

```
var bytes: [CChar] = [1, 2, 3]
// 实例情况下使用size(ofValue: )
MemoryLayout.size(ofValue: bytes) //8

enum MyEnum: IntegerLiteralType {
    case A = 100
    case B = 1
    case C = 2
    case D = 3
}

MemoryLayout<Any>.size //32
MemoryLayout<MyEnum>.size == 1 //true

struct xPoint {
    let x: Double //8
    let y: Double //8
    let isFilled: Bool //1
}

// 连续的内存占用量T，以字节为单位
MemoryLayout<xPoint>.size == 17

// 存储在连续存储器或存储器中的一个实例的开始到下一个实例的开始的字节数
MemoryLayout<xPoint>.stride == 24

// 默认内存对齐方式T，以字节为单位
MemoryLayout<xPoint>.alignment == 8

// 引用性
class yPoint {
    let x: Double = 0.0
    let y: Double = 0.0
    let isFilled: Bool = false
}

MemoryLayout<yPoint>.size == 8
MemoryLayout<yPoint>.stride == 8
MemoryLayout<yPoint>.alignment == 8

```
class是对象类型数据，使用MemoryLayout对class类型计算其内存结果实际上是对其class类型的引用指针进行操作

跨度同时也决定内存大小

```
// 相同元素，不同顺序，他们的内存大小相差很大
struct Puppy {
  let age: Int
  let isTrained: Bool
} // Int, Bool

struct AlternatePuppy { 
  let isTrained: Bool
  let age: Int
} 
```

结果

```
MemoryLayout<Puppy>.size == 9
MemoryLayout<AlternatePuppy>.size == 17
```

> **当我们在写struct 时候要注意内存的分布**

stride【跨度】在32位是4 在64是8

```
MemoryLayout<Int32>.size == 4
MemoryLayout<Int64>.size == 8
```

**结论**

每个对象的起始地址必须是其对齐方式的倍数。该规则适用于所有内容-结构中的属性（Int，Bool等），结构本身以及所有其他类型
让我们看看你的最后一个例子- CertifiedPuppy3：
- 定位为isTrained（布尔）为1，这意味着它可以在任何地址开始，所以它从0开始
- 定位为isCertified（布尔）也为1，所以没有问题isCertified从1开始。
- age（Int）的对齐方式为8，因此它只能从0、8、16、24开始。这就是为什么age的起始地址为8，而不是2。处于2时将不对齐。
- 因此，CertifiedPuppy3的大小为16，因为其属性必须遵循对齐规则。

与问题无关，还有以下内容：

> 结构的对齐方式等于其属性的最大对齐方式。

这就是为什么CertifiedPuppy2的步幅为24：CertifiedPuppy2的对齐方式为8，因为其大小为17，因此，新的CertifiedPuppy2对象的下一个开始可用位置为24-这就是步幅-两个CertifiedPuppy2对象之间的最小距离。

![1](/img/size-stride-alignment/qxq0r.jpg)

参考
> [https://swiftunboxed.com/internals/size-stride-alignment/](https://swiftunboxed.com/internals/size-stride-alignment/)