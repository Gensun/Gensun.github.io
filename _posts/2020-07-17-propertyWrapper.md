---
layout: post
title: "propertyWrapper"
subtitle: "属性包装类"
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.7
tags:
  -  swift
---

通过包装类可以大大减少的code 量
首先通过UserDefaults 来看下

1. enums 创建keys

```
extension UserDefaults {
    enum Keys {
        static let isFirstLaunch = "isFirstLaunch"
    }
  }
```

2. 建立包装类

```
@propertyWrapper
struct UserDefaultWrapper<T> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
```

3. 可以通过manage管理	

```
class UserDefaultsManage {
    @UserDefaultWrapper(key: UserDefaults.Keys.isFirstLaunch, defaultValue: false)
    var isFirstLaunch: Bool
}

```

4. 调用

```
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let value = UserDefaultWrapper(key: UserDefaults.Keys.isFirstLaunch, defaultValue: true)
        print(value.wrappedValue)

        print(UserDefaultsManage().isFirstLaunch)
    }
}

```


参考：

[https://nshipster.com/propertywrapper/](https://nshipster.com/propertywrapper/)