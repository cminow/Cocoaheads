//
//  DateFormatter.swift
//  Payday
//
//  Created by Charlie Minow on 3/22/25.
//

import Foundation

extension DateFormatter {
    static let displayTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = .current
        formatter.timeZone = .autoupdatingCurrent
        formatter.dateStyle = .medium
        return formatter
    }()
}
