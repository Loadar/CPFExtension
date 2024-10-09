//
//  Date+Offset.swift
//  
//
//  Created by Aaron on 2023/6/2.
//

import Foundation
import CPFChain

extension Date: @retroactive CpfCompatible {}

public extension Cpf where Wrapped == Date.Type {
    /// 一天的秒数(60 * 60 * 24s)，方便用于计算
    var secondsOfOneDay: TimeInterval { 86400 }
    
    /// 前天
    var dayBeforYesterday: Date {
        let date = Date(timeIntervalSinceNow: secondsOfOneDay * -2)
        return Util.calendar.startOfDay(for: date)
    }
    
    /// 昨天
    var yesterday: Date {
        let date = Date(timeIntervalSinceNow: secondsOfOneDay * -1)
        return Util.calendar.startOfDay(for: date)
    }
    
    /// 今天
    var today: Date {
        return Util.calendar.startOfDay(for: Date())
    }
    
    /// 明天
    var tommorow: Date {
        return Util.calendar.startOfDay(for: Date(timeIntervalSinceNow: secondsOfOneDay))
    }
}

public extension Cpf where Wrapped == Date {
    /// 生成当前日期偏移指定天数的新日期
    /// - Parameters:
    ///   - dayOffset: 天数偏移，负值往前，正值往后
    ///   - timeReset: 是否重置时间，为true的时候，会将时间重置为当天0点；默认false
    func day(offset: Int, timeReset: Bool = false) -> Date {
        guard offset != 0 else { return wrapped }
        
        var finalDate: Date = {
            let newDate: Date
            // 注意：使用calendar计算日期偏移返回的是可选值，虽然绝大部分时候都不会返回nil，这里做个兼容
            if let theDate = Util.calendar.date(byAdding: .day, value: offset, to: wrapped) {
                newDate = theDate
            } else {
                // 使用calendar获取失败时，直接使用时间偏移来计算
                newDate = Date(timeInterval: Date.cpf.secondsOfOneDay * Double(offset), since: wrapped)
            }
            return newDate
        }()
        
        if timeReset {
            finalDate = Util.calendar.startOfDay(for: finalDate)
        }
        return finalDate
    }
    
    /// 生成指定日期偏移指定月的新日期
    /// - Parameters:
    ///   - monthOffset: 月偏移，负值往前，正值往后
    ///   - timeReset: 是否重置时间，为true的时候，会将时间重置为当天0点；默认false
    func month(offset: Int, timeReset: Bool = false) -> Date {
        guard offset != 0 else { return wrapped }

        var finalDate: Date = {
            let newDate: Date
            // 注意：使用calendar计算日期偏移返回的是可选值，虽然绝大部分时候都不会返回nil，这里做个兼容
            if let theDate = Util.calendar.date(byAdding: .month, value: offset, to: wrapped) {
                newDate = theDate
            } else {
                // 使用calendar获取失败时，直接使用时间偏移来计算, 不太好指定月，默认为30天
                let allSeconds = Date.cpf.secondsOfOneDay * Double(offset * 30)
                newDate = Date(timeInterval: allSeconds, since: wrapped)
            }
            return newDate
        }()
        
        if timeReset {
            finalDate = Util.calendar.startOfDay(for: finalDate)
        }
        return finalDate
    }
    
    /// 生成当前日期偏移指定年的新日期
    /// - Parameters:
    ///   - yearOffset: 年偏移，负值往前，正值往后
    ///   - timeReset: 是否重置时间，为true的时候，会将时间重置为当天0点；默认false
    func year(offset: Int, timeReset: Bool = false) -> Date {
        guard offset != 0 else { return wrapped }
        
        var finalDate: Date = {
            let newDate: Date
            // 注意：使用calendar计算日期偏移返回的是可选值，虽然绝大部分时候都不会返回nil，这里做个兼容
            if let theDate = Util.calendar.date(byAdding: .year, value: offset, to: wrapped) {
                newDate = theDate
            } else {
                // 使用calendar获取失败时，直接使用时间偏移来计算, 不太好指定年，默认为365天
                let allSeconds = Date.cpf.secondsOfOneDay * Double(offset * 365)
                newDate = Date(timeInterval: allSeconds, since: wrapped)
            }
            return newDate
        }()
        
        if timeReset {
            finalDate = Util.calendar.startOfDay(for: finalDate)
        }
        return finalDate
    }
}

public extension Cpf where Wrapped == Date {
    /// 从指定日期到当前日期相隔的天数
    func dayOffset(from date: Date) -> Int {
        Self.dayOffset(from: date, to: wrapped)
    }
    
    /// 从当前日期到指定日期相隔的天数
    func dayOffset(to date: Date) -> Int {
        Self.dayOffset(from: wrapped, to: date)
    }
    
    /// 指定的2个相隔的天数
    static func dayOffset(from startDate: Date, to endDate: Date) -> Int {
        let calendar = Util.calendar
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        assert(components.day != nil, "天数计算异常")
        return components.day ?? 0
    }
}

public extension Cpf where Wrapped == Date {
    /// 当前的时间戳
    static var currentTimeStamp: Int64 {
        Int64(Date().timeIntervalSince1970)
    }
}
