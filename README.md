# UNSwiftyUD

## Usage

```swift
// Declare UDBase Subclass

class Melon: UDBase {
    dynamic var owner: String = ""
    dynamic var int: Int = 0
}

print(Melon().owner)
Melon().owner = "WaterMelon is not Melon"
```
This will store in userdefault with key "Melon-owner" and "Melon-int"

