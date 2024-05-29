//
//  File.swift
//  
//
//  Created by Aaron on 2023/6/6.
//

import Foundation

public extension Date {
    /// 一天的秒数(60 * 60 * 24s)，方便用于计算
    static var cpfSecondsOfOneDay: TimeInterval {
        self.cpf.secondsOfOneDay
    }
    
    /// 前天
    static var cpfDayBeforYesterday: Date {
        self.cpf.dayBeforYesterday
    }

    /// 昨天
    static var cpfYesterday: Date {
        self.cpf.yesterday
    }
    
    /// 今天
    static var cpfToday: Date {
        self.cpf.today
    }
    
    /// 明天
    static var cpfTommorow: Date {
        self.cpf.tommorow
    }
}
