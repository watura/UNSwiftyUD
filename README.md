# UNSwiftyUD

## Usage

```swift
// Declare UDBase Subclass

class Melon: UDBase {
    dynamic var string: String? = ""
    dynamic var int: Int = 0
}

print(Melon().string)
Melon().string = "WaterMelon is not Melon"
```
This will store in userdefault with key "Melon-string" and "Melon-int"

