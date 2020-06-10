---
layout: post
title: "我们何时应使用{ get set }以及{ get }何时声明协议的属性要求"
subtitle: "{ get set } & { get }"
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  swift
---

先看下代码 👏 

```
protocol MyProtocol {
    var var1: String { get set }
    var var2: String { get }
}

struct MyStruct: MyProtocol {
    var var1: String = ""
    var var2: String = ""
}

let st = MyStruct(var1: "1", var2: "2")
st.var1  //1
st.var2  //2
```

当我们实例化 `MyStruct ` 为 `MyProtocol ` 类型 出现错误，说明：_{ get set } & { set } 在protocol 级有效_

```
var testProtocol: MyProtocol = MyStruct()
testProtocol.var1 = "test var1" // No error
testProtocol.var2 = "test var2" // error: cannot assign to property: 'myVar2' is a get-only property

```

在声明协议的属性要求时，请始终使用{get}，除非您非常确定要同时设置它和settable。

```
protocol Flyable {
    /// Limit the speed of flyable
    var speedLimit: Int { get }

    func fly()
}

extension Flyable {
    func fly() {
        print("Fly with speed limit: \(speedLimit)mph")
    }
}

class Airplane: Flyable {
    var speedLimit = 500
}

class 直升飞机: Flyable {
    var speedLimit = 150
}


class SpeedLimitUpdater {
    static func reduceSpeedLimit(of flyables: [Flyable], by value: Int) {
        // Only update speedLimit of Helicopter & Airplane
        for flyable in flyables {
            if let helicopter = flyable as? 直升飞机 {
                helicopter.speedLimit -= value
            } else if let airplane = flyable as? Airplane {
                airplane.speedLimit -= value
            }
        }
    }

    static func increaseSpeedLimit(of flyables: [Flyable], by value: Int) {
        // Only update speedLimit of Helicopter & Airplane
        for flyable in flyables {
            if let helicopter = flyable as? 直升飞机 {
                helicopter.speedLimit += value
            } else if let airplane = flyable as? Airplane {
                airplane.speedLimit += value
            }
        }
    }
}

class Bird: Flyable {
    private(set) var speedLimit = 20
}

// Bird 不是机器不能使用 SpeedLimitUpdater，Bird 的speedLimit限制private(set)
let bbb = Bird()
SpeedLimitUpdater.increaseSpeedLimit(of: [bbb], by: 1)
bbb.speedLimit //20

```

//当然我们可以内部更改

```
class Bird: Flyable {
    private(set) var speedLimit = 20
    func changeSpeed() {
        speedLimit += 10
    }
}
bbb.changeSpeed()
bbb.speedLimit //30
```