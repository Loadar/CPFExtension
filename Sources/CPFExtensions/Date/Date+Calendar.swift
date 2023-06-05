//
//  Date+Calendar.swift
//  
//
//  Created by Aaron on 2023/6/5.
//

import Foundation
import CPFChain

public extension Cpf where Wrapped == Date {
    var startOfMonth: Date? {
        let calendar = Util.calendar
        let components = calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: wrapped))
        return calendar.date(from: components)
    }
    
    var endOfMonth: Date? {
        guard let startDay = startOfMonth else { return nil }
        let calendar = Util.calendar
        // 月初加1月再减一天得到月末
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDay)
    }
}
