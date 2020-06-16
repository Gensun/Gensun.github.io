---
layout: post
title: "enum 的 allValues"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  swift
---

enum 在 java 或其他的语言中都有allValues，swift 中无，我们如何来实现：
```
enum Suit: String, EnumType {
    case A
    case B
    case C
    case D

    static var allValues: [Suit] {
        return [.A, .B, .C, .D]
    }
}

enum Rank: Int, EnumType {
    typealias RawValue = Int

    case Ace = 1
    case Two, Three
    case Jack

    var description: String {
        switch self {
        case .Ace:
            return "A"
        case .Jack:
            return "J"
        default:
            return String(self.rawValue)
        }
    }

    static var allValues: [Rank] {
        return [.Ace, .Two, .Three, Jack]
    }
}

protocol EnumType {
    static var allValues: [Self] { get }
}

for suit in Suit.allValues {
    for rank in Rank.allValues {
        print("\(suit.rawValue)\(rank.rawValue)")
    }
}

```