//
//  TimeInterval.swift
//  Payday
//
//  Created by Charlie Minow on 3/22/25.
//

import Foundation

extension TimeInterval {
    static let daysFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day]
        formatter.zeroFormattingBehavior = [.dropAll]
        return formatter
    }()

    static let fancyFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.weekOfMonth, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.dropLeading, .dropMiddle]
        return formatter
    }()

    static let listIntervalFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.weekOfMonth, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.dropAll]
        return formatter
    }()
}
