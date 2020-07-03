---
layout: post
title: "new in swift4"
subtitle: " "
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  swift
---

# 单面范围 
> One-sided ranges

swift 引进了 `RangeExpression ` 协议 和一组 `[1...]` `[...10]` 运算符方式形成单边范围。
> 从表面上看，是无下限和无上限

## 无限序列 
>   Infinite Sequences

```
let letters = ["a","b","c","d"]
let numberedLetters = zip(1..., letters)
Array(numberedLetters)

let wizards2 = ["Harry", "Ron", "Hermione", "Draco"]
let animals2 = ["Hedwig", "Scabbers", "Crookshanks"]

for (wizard, animal) in zip(wizards2, animals2) {
    print("\(wizard) has \(animal)")
}

```

`zip` 使用 [https://www.hangge.com/blog/cache/detail_1829.html](https://www.hangge.com/blog/cache/detail_1829.html) 


# 集合下标
当您使用单面范围下标到集合时，集合的startIndex或endIndex分别“填充”缺少的下限或上限。

```
let numbers = [1,2,3,4,5,6,7,8,9,10]
numbers[5...] // instead of numbers[5..<numbers.endIndex]

```

#模式匹配

一侧范围可用于模式匹配结构中，例如在switch语句中的case表达式中。请注意，尽管如此，编译器仍无法确定转换是否详尽无遗。

```
let value = 5
switch value {
case 1...:
    print("greater than zero")
case 0:
    print("zero")
case ..<0:
    print("less than zero")
default:
    fatalError("unreachable")
}

```

# String

## 多行显示字符串

通过 `"""  mes """`

```
let multilineString = """
    This is a multi-line string.
    You don't have to escape "quotes" in here.
    String interpolation works as expected: 2 + 3 = \(2 + 3)
    The position of the closing delimiter
      controls whitespace stripping.
    """
print(multilineString)
```

## 字符串文字中转义换行符

```
let escapedNewline = """
    To omit a line break, \
    add a backslash at the end of a line.
    """
print(escapedNewline)
```

## string is collections

```
let greeting = "Hello, 😜!"
// No need to drill down to .characters
greeting.count
for char in greeting {
    print(char)
}
```


```
let comma = greeting.firstIndex(of: ",")!
let substring = greeting[..<comma]
type(of: substring)
// Most String APIs can be called on Substring
print(substring.uppercased())
print("---")
```

> 传递给其他API时，这可能导致意外的高内存使用
>  要将子字符串转换回字符串，请使用String（）初始化程序。这会将子字符串复制到新缓冲区中：

```
let newString = String(substring)
type(of: newString)

```

在Range <String.Index>和NSRange之间转换

Foundation在NSRange和Range <String.Index>上提供了新的初始化程序，可以在两者之间进行转换，从而无需手动计算UTF-16偏移量。这使得使用仍可在NSRanges上使用的API（例如NSRegularExpression和NSAttributedString）更加容易。

```
// Given a String range
let string = "Hello 👩🏽‍🌾👨🏼‍🚒💃🏾"
let index = string.firstIndex(of: Character("👩🏽‍🌾"))!
let range = index...

print(range.lowerBound)
// Convert the String range to an NSRange
import Foundation

let nsRange = NSRange(range, in: string)
nsRange.length // length in UTF-16 code units
string[range].count // length in Characters
assert(nsRange.length == string[range].utf16.count)

// Use the NSRange to format an attributed string
import UIKit

let formatted = NSMutableAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 14)])
formatted.addAttribute(.font, value: UIFont.systemFont(ofSize: 48), range: nsRange)

// NSAttributedString APIs return NSRange
let lastCharacterIndex = string.index(before: string.endIndex)
let lastCharacterNSRange = NSRange(lastCharacterIndex..., in: string)
var attributesNSRange = NSRange()
_ = formatted.attributes(at: lastCharacterNSRange.location, longestEffectiveRange: &attributesNSRange, in: nsRange)
attributesNSRange

// Convert the NSRange back to Range<String.Index> to use it with String
let attributesRange = Range(attributesNSRange, in: string)!
string[attributesRange]

```

extension 中可以访问 private 的属性

```
struct SortedArray<Element: Comparable> {
    private var storage: [Element] = []
    init(unsorted: [Element]) {
        storage = unsorted.sorted()
    }
}

extension SortedArray {
    mutating func insert(_ element: Element) {
        // storage is visible here
        storage.append(element)
        storage.sort()
    }
}

let array = SortedArray(unsorted: [3,1,2])
```

# key paths

与Cocoa中基于字符串的键路径不同，Swift键路径是强类型的

```
struct Person {
    var name: String
}

struct Book {
    var title: String
    var authors: [Person]
    var primaryAuthor: Person {
        return authors.first!
    }
}

let abelson = Person(name: "Harold Abelson")
let sussman = Person(name: "Gerald Jay Sussman")
let book = Book(title: "Structure and Interpretation of Computer Programs", authors: [abelson, sussman])

```

密钥路径是通过从根类型开始并向下钻取属性和下标名称的任意组合而形成的。

您可以通过以反斜杠开头来写关键路径：\ Book.title。每种类型都会自动获取[keyPath：…]下标，以获取或设置指定键路径处的值。

```
book[keyPath: \Book.title]
book[keyPath: \Book.primaryAuthor.name]
book[keyPath: \Book.authors]

```
关键路径是可以存储和操作的对象。例如，您可以将其他段附加到关键路径上，以进行进一步细化。

```
let authorKeyPath = \Book.primaryAuthor
type(of: authorKeyPath)
// You can omit the type name if the compiler can infer it
let nameKeyPath = authorKeyPath.appending(path: \.name)
book[keyPath: nameKeyPath]
```

关键路径建议的一部分是关键路径可以包含下标段。这将使它们非常方便地深入到集合中

```
book[keyPath: \Book.authors[0].name]
```

具有关键路径的类型安全的KVO

Foundation中的键值观察API已进行了改进，以充分利用新的类型安全的键路径。它比旧的API更易于使用。

注意，KVO取决于Objective-C运行时。它仅在NSObject的子类中起作用，并且任何可观察的属性都必须使用@objc dynamic声明。

```
import Foundation

class Child: NSObject {
    let name: String
    // KVO-enabled properties must be @objc dynamic
    @objc dynamic var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
        super.init()
    }

    func celebrateBirthday() {
        age += 1
    }
}

// Set up KVO
let mia = Child(name: "Mia", age: 5)
let observation = mia.observe(\.age, options: [.initial, .old]) { (child, change) in
    if let oldValue = change.oldValue {
        print("\(child.name)’s age changed from \(oldValue) to \(child.age)")
    } else {
        print("\(child.name)’s age is now \(child.age)")
    }
}

// Trigger KVO (see output in the console)
mia.celebrateBirthday()

// Deiniting or invalidating the observation token ends the observation
observation.invalidate()

// This doesn't trigger the KVO handler anymore
mia.celebrateBirthday()

```

#  归档和序列化

```
// Make a custom type archivable by conforming it (and all its members) to Codable
struct Card: Codable, Equatable {
    enum Suit: String, Codable {
        case clubs, spades, hearts, diamonds
    }

    enum Rank: Int, Codable {
        case two = 2, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    }

    var suit: Suit
    var rank: Rank

    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.suit == rhs.suit && lhs.rank == rhs.rank
    }
}

let hand = [Card(suit: .clubs, rank: .ace), Card(suit: .hearts, rank: .queen)]
```

## Encoding

Swift还将随附一组内置的编码器和解码器，用于JSON（JSONEncoder和JSONDecoder）和属性列表（PropertyListEncoder和PropertyListDecoder）。这些在SE-0167中定义。 NSKeyedArchiver也将支持所有Codable类型。

```
var encoder = JSONEncoder()

// Optional properties offered by JSONEncoder for customizing output
encoder.outputFormatting = [.prettyPrinted] // another option: .sortedKeys
encoder.dataEncodingStrategy
encoder.dateEncodingStrategy
encoder.nonConformingFloatEncodingStrategy

// Every encoder and decoder has a userInfo property to pass custom configuration down the chain. The supported keys depend on the specific encode/decoder.
encoder.userInfo

let jsonData = try encoder.encode(hand)
String(data: jsonData, encoding: .utf8) //json string
try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) //字典
```

## Decoding

```
let decoder = JSONDecoder()
let decodedHand = try decoder.decode([Card].self, from: jsonData)
type(of: decodedHand)
assert(decodedHand == hand)
```

# Sequence.Element

## 序列现在具有其自己的元素关联类型。新的泛型功能使之成为可能，因为关联类型Element现在可以在类型系统中表示，其中Element == Iterator.Element。

```
extension Sequence where Element: Numeric {
    var sum: Element {
        var result: Element = 0
        for element in self {
            result += element
        }
        return result
    }
}

[1,2,3,4,5].self //[1,2,3,4,5]
[1,2,3,4,5].sum //15

```

## Collection的关联索引类型的元素具有与Collection.Index相同的类型：

```

extension MutableCollection {
    /// 在适当位置映射集合中的元素，替换现有元素
    /// 具有其转换值的元素。

    mutating func mapInPlace(_ transform: (Element) throws -> Element) rethrows {
        for index in indices {
            self[index] = try transform(self[index])
        }
    }
}

var tt = [11, 22, 33]
tt.mapInPlace { (i) -> Int in
    print(i)
    if i == 11 {
        return 111
    }
    return i
}

```

# 字典和set 增强

## 通过key-value生成字典

```
let names1 = ["Cagney", "Lacey", "Bensen"]
let dict1 = Dictionary(uniqueKeysWithValues: zip(1..., names1))
dict1[2]
```

## 合并初始化器和合并方法
### 指定从序列创建字典或将序列合并到现有字典时应如何处理重复键。

```
let names1 = ["Cagney", "Lacey", "Bensen"]
let dict1 = Dictionary(uniqueKeysWithValues: zip(1..., names1))
dict1[2]

let duplicates = [("a", 1), ("b", 2), ("a", 3), ("b", 4), ("a", 10)]
// 顺序遍历取最开始的
let letters = Dictionary(duplicates, uniquingKeysWith: { first, _ in first })
letters
//取最后的
let ghu = Dictionary(duplicates) { _, last in last }
ghu
// 取最大的value
let maxOne = Dictionary(duplicates) { first, last in
    if first > last {
        return first
    }
    return last
}
maxOne
```

## merge

```
var defaults = ["darkUI": false, "energySaving": false, "smoothScrolling": false]
var options = ["darkUI": true, "energySaving": false]
// 以options为主
options.merge(defaults) { (old, _) in old }
options
// 以defaults为主
defaults.merge(options) { (old, _) -> Bool in
    old
}
defaults
// 以options为主
defaults.merge(options) { (_, new) -> Bool in
    new
}
defaults
```

## 通过default设置默认值

提供默认值作为下标4的值，可使返回值不为可选值

` dict1[4, default: "(unknown)"]`

> 其实目前 `dict1` 的count 值还是3，下标4为nil，所以会感觉无用啊

但当您想通过下标更改值时，这特别有用：
计算一串字符串字符出现的次数，默认为0开始

```
let source = "how now brown cow"
var frequencies: [Character: Int] = [:]
for c in source {
    frequencies[c, default: 0] += 1
}
frequencies

```

## 字典的特定map 和 filter

字典下filter 返回的还是字典，同样mapValues方法在保留字典结构

```
// 筛选出偶数
let filtered = dict1.filter{( $0.key % 2 == 0 )}
filtered
type(of: filtered)
```

`mapValues ` 取到字典的value，做处理 -> 小写变大写

```
let mapped = dict1.mapValues({ $0.uppercased() })
mapped
```

## set

> Set.filter也立即返回Set而不是Array。

```
// 筛选出偶数值
let set: Set = [1,2,3,4,5]
let filteredSet = set.filter({ $0 % 2 == 0})
filteredSet
type(of: filteredSet)
```

## 分组序列

### 将值序列分组到存储桶中

```
let contacts = ["sun", "cheng", "anda", "muthie", "ethan","cun","ehiu"]
//通过单词首字母对单词列表中的单词进行划分
let grouped = Dictionary(grouping: contacts, by: { $0.first })
grouped
//通过单词末尾字母对单词列表中的单词进行划分
let groupedLast = Dictionary(grouping: contacts, by: { $0.last })
groupedLast
```

# swapAt

```
// 交换下标0和1位置
var numbers = [1,2,3,4,5]
numbers.swapAt(0, 1)
numbers

```

# reduce with inout

```
// 去除连续重复项
extension Sequence where Element: Equatable {
    func removingConsecutiveDuplicates() -> [Element] {
        return reduce(into: []) { (result: inout [Element], element) in
            if element != result.last {
                result.append(element)
            }
        }
    }
}

[1, 1, 2, 1, 12, 12, 123, 12, 13].removingConsecutiveDuplicates()

let g = [1, 1, 1, 2, 3, 3, 4].reduce(0, -)

```

# 通用下标

```
struct JSON {
    fileprivate var storage: [String:Any]

    init(dictionary: [String:Any]) {
        self.storage = dictionary
    }

    subscript<T>(key: String) -> T? {
        return storage[key] as? T
    }
}

let json = JSON(dictionary: [
    "name": "Berlin",
    "country": "de",
    "population": 3_500_500
    ])

// No need to use as? Int
let population: Int? = json["population"]
```

另一个示例：Collection上的下标，该下标采用通用的索引序列，并在这些索引处返回值的数组：

```
extension Collection {
    subscript<Indices: Sequence>(indices indices: Indices) -> [Element] where Indices.Element == Index {
        var result: [Element] = []
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}

let words = "Lorem ipsum dolor sit amet".split(separator: " ")
words[indices: [1,2]]
```

# 新的整数协议

协议层次结构如下所示

![1](/img/swift4/integer-protocols.png)

# NSNumber Bridging

```
let n = NSNumber(value: UInt32(543))
let v = n as? Int8  
```

```
NSNumber(value: 0.1) as? Double //0.1
NSNumber(value: 0.1) as? Float // nil
NSNumber(value: 0.1) as? Float32 //nil
NSNumber(value: 0.1) as? Float64 //0.1
```

> /// A 32-bit floating point type.
> 
> `public typealias Float32 = Float ` 看了定义Float32就是Float 

# @nonobjc

在扩展名上使用@nonobjc可以为扩展名中的所有声明禁用@objc推断

```
@nonobjc extension MyClass2 {
    func wobble() { } // not @objc, despite @objcMembers
}

```

# 编写类和协议

现在可以在Swift中编写与Objective-C代码类似的UIViewController <SomeProtocol> *，即声明一个具体类型的变量，并将其同时限制在一个或多个协议中。语法为let变量：SomeClass＆SomeProtocol1＆SomeProtocol2。

```
import UIKit

protocol HeaderView {}

class ViewController: UIViewController {
    let header: UIView & HeaderView

    init(header: UIView & HeaderView) {
        self.header = header
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder decoder: NSCoder) {
        fatalError("not implemented")
    }
}
extension UIImageView: HeaderView {}

ViewController(header: UIImageView()) // works

```