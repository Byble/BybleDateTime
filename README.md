# BybleDateTime

Custom Date Time Library

Not yet Date compare func function
There is Only time compare function

This Library is for who need hour over than 24h

## How to Initialize 
```swift
public init(dateCom: String, timeCom: String, hourRange: Int)
public init(timeCom: String, hourRange: Int)
public init(dateCom: String)
public init(str: String, dateCom: String, timeCom: String, hourRange: Int)
public init(str: String, dateCom: String)
public init(str: String, timeCom: String, hourRange: Int)
```

dateCom means like In 2019-12-25 dateCom would be "-"
timeCom means like In 12:12:12 timeCom would be ":"
hourRange is that you can determine time range

EX : 23 
hour would be 0 ~ 23h

EX : 31
hour would be 8 ~ 31h

## Get Time by String with function   
#### (you could just access each variable even if you don't use this functions)

```swift
public func GetDateStr() -> String
public func GetTimeStr() -> String
public func GetStr() -> String
```

## Compare Time

```swift
public func CompareTime(data: DateTime) -> Float
public func CompareTimeToStruct(data: DateTime) -> Time
public func CompareTimeToStr(data: DateTime) -> String
```

## There is also Time Struct

```swift
public struct Time {
    var hour: Int
    var minute: Int
    var second: Float
    init (hour: Int, minute: Int, second: Float){
        self.hour = hour
        self.minute = minute
        self.second = second
    }
}
```

## Sample Code

```swift
import BybleDateTime

let date = DateTime(str: "2020-12-12 30:30:30", dateCom: "-", timeCom: ":", hourRange: 31)
let date2 = DateTime(str: "2020-12-12 29:30:30", dateCom: "-", timeCom: ":", hourRange: 31)

print(date.CompareTime(data: date2))
print(date.GetStr())
print(date.date)
```
