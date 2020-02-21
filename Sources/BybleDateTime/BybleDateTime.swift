//
//  BybleDateTime.swift
//  time
//
//  Created by KIM MINGUK on 2019/12/22.
//  Copyright © 2019 KIM MINGUK. All rights reserved.
//

import Foundation

public struct Time{
    var hour: Int
    var minute: Int
    var second: Float
    init (hour: Int, minute: Int, second: Float){
        self.hour = hour
        self.minute = minute
        self.second = second
    }
}

public struct DateTime{
    var timeCom = ":"
    var dateCom = "-"

// YEAR-MONTH-DATE System
//--------------------------------------------------------------------
    private var _year: Int = 2000
    public var year: Int{
        get{
            return _year
        }
        set{
            _year = newValue
        }
    }
    private var _month: Int = 1
    public var month: Int{
        get{
            return _month
        }
        set{
            if (newValue > 12){
                let tmp = newValue / 12
                _month = newValue % 12
                year += (1 * tmp)
            }else{
                _month = newValue
            }
        }
    }
    private var _date: Int = 1
    public var date: Int{
        get{
            return _date
        }
        set{
            if newValue > 28{
                switch month {
                case 1,3,5,7,8,10,12:
                    if (newValue > 31){
                        let tmp = newValue / 31
                        _date = newValue % 31
                        month += (1 * tmp)
                    }
                    break
                case 4,6,9,11:
                    if (newValue > 30){
                        let tmp = newValue / 30
                        _date = newValue % 30
                        month += (1 * tmp)
                    }
                    break
                case 2:
                    if (CheckLeapYear()){
                        if (newValue > 29){
                            let tmp = newValue / 29
                            _date = newValue % 29
                            month += (1 * tmp)
                        }
                    }else{
                        if (newValue > 28){
                            let tmp = newValue / 28
                            _date = newValue % 28
                            month += (1 * tmp)
                        }
                    }
                    break
                default:
                    break
                }
            }else{
                _date = newValue
            }
        }
    }
    
    private func CheckLeapYear() -> Bool{
        if year % 4 == 0{
            if year % 400 == 0{
                return true
            }
            if year % 100 == 0{
                return false
            }
            return true
        }else{
            return false
        }
    }
//--------------------------------------------------------------------

// HOUR:MINUTE:SECOND System
//--------------------------------------------------------------------
    static let DayHour = 24
    public var hourRange = Int.max
    
    private var _hour: Int = 0
    public var hour: Int{
        get{
            return _hour
        }
        set{
            if (newValue > hourRange){
                let tmp = Int(newValue/hourRange)
                _hour = newValue % (DateTime.DayHour)
                date += (1 * tmp)
            }else{
                _hour = newValue
            }
        }
    }
    
    private var _minute: Int = 0
    public var minute: Int{
        get{
            return _minute
        }
        set{
            if (newValue > 59){
                let tmp = Int(newValue/60)
                _minute  = newValue % 60
                hour += (1 * tmp)
            }else{
                _minute = newValue
            }
        }
    }
    
    private var _second: Float = 0.000
    public var second: Float{
        get{
            return _second
        }
        set{
            if (newValue >= 60){
                let tmp = Int(newValue/60)
                _second = newValue.truncatingRemainder(dividingBy: 60)
                minute += (1 * tmp)
            }else{
                _second = newValue
            }
        }
    }
    
    public func GetDateStr() -> String{
        return "\(year)-\(month)-\(date)"
    }
    public func GetTimeStr() -> String{
        return "\(hour):\(minute):\(second)"
    }
    public func GetStr() -> String{
        return "\(year)-\(month)-\(date) \(hour):\(minute):\(second)"
    }

    public func IsNight(h: Int, m: Int) -> Bool{
        if self.hour >= h && self.minute >= m{
            return true
        }else{
            return false
        }
    }
    public func CompareTime(data: DateTime) -> Float{
        let hourToMin = 60 * (self.hour - data.hour)
        let minToSec = ((hourToMin + self.minute) - data.minute) * 60
        let sec = (Float(minToSec) + self.second) - data.second
        
        return abs(sec)
    }
    public func CompareTimeToStruct(data: DateTime) -> Time{
        let hourToMin = 60 * (self.hour - data.hour)
        let minToSec = ((hourToMin + self.minute) - data.minute) * 60
        let sec = (Float(minToSec) + self.second) - data.second
                        
        let toHour: Int = Int(abs(sec) / 3600)
        let tmpSec = sec - Float(3600*toHour)
        let toMin: Int = Int(tmpSec/60)
        var toSec: Float = tmpSec.truncatingRemainder(dividingBy: 60)
        let time = Time(hour: toHour, minute: toMin, second: toSec.roundToPlaces(places: 3))
        return time
    }
    public func CompareTimeToStr(data: DateTime) -> String{
        let hourToMin = 60 * (self.hour - data.hour)
        let minToSec = ((hourToMin + self.minute) - data.minute) * 60
        let sec = (Float(minToSec) + self.second) - data.second
                        
        let toHour: Int = Int(abs(sec) / 3600)
        let tmpSec = sec - Float(3600*toHour)
        let toMin: Int = Int(tmpSec/60)
        var toSec: Float = tmpSec.truncatingRemainder(dividingBy: 60)
        
        return "\(toHour):\(toMin):\(String(format: "%.3f", toSec.roundToPlaces(places: 3)))"
    }
    static func > (left: inout DateTime, right: DateTime) -> Bool{
        if left.year > right.year { return true}
        else if left.year < right.year{ return false}
        
        if left.month > right.month { return true}
        else if left.month < right.month { return false }
        
        if left.date > right.date { return true }
        else if left.date < right.date { return false }
        
        if left.hour > right.hour { return true }
        else if left.hour < right.hour { return false }
        
        if left.minute > right.minute { return true }
        else if left.minute < right.minute { return false}
        
        if left.second > right.second { return true }
        else if left.second < right.second { return false }
        
        return false
    }
//    public func CompareDate(data: DateTime) -> DateTime{
//        var tmp = DateTime(dateCom: self.dateCom)
//        let Year = self.year - data.year
//        let Month = self.month - data.month
//        return tmp
//    }
//    public func CompareBoth(data: DateTime) -> DateTime{
//
//        return tmp
//    }
    public init(dateCom: String, timeCom: String, hourRange: Int){
        self.timeCom = timeCom
        self.dateCom = dateCom
        self.hourRange = hourRange
    }
    public init(timeCom: String, hourRange: Int){
        self.timeCom = timeCom
        self.hourRange = hourRange
    }
    public init(dateCom: String){
        self.dateCom = dateCom
    }
    
    public init(str: String, dateCom: String, timeCom: String, hourRange: Int) {
        let com1 = str.components(separatedBy: " ")
        let com2 = com1[0].components(separatedBy: dateCom)
        _year = Int(com2[0])!
        _month = Int(com2[1])!
        _date = Int(com2[2])!
        
        let com3 = com1[1].components(separatedBy: timeCom)
        _hour = Int(com3[0])!
        _minute = Int(com3[1])!
        _second = Float(com3[2])!
        
        self.timeCom = timeCom
        self.dateCom = dateCom
        self.hourRange = hourRange
    }
    
    public init(str: String, dateCom: String) {
        let com2 = str.components(separatedBy: dateCom)
        _year = Int(com2[0])!
        _month = Int(com2[1])!
        _date = Int(com2[2])!
        
        self.dateCom = dateCom
    }
    
    public init(str: String, timeCom: String, hourRange: Int) {
        let com3 = str.components(separatedBy: timeCom)
        _hour = Int(com3[0])!
        _minute = Int(com3[1])!
        _second = Float(com3[2])!
        
        self.timeCom = timeCom
        self.hourRange = hourRange
    }
}

extension Float {
    mutating func roundToPlaces(places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return roundf(self * divisor) / divisor
    }
}
