//
//  Meeting.swift
//  Cocoaheads
//
//  Created by Charlie Minow on 7/28/26.
//

import Foundation

struct Meeting: Identifiable {
    let date: Date
    var id: TimeInterval { return date.timeIntervalSinceReferenceDate }

    var stringValue: String {
        return DateFormatter.displayTime.string(from: date)
    }

    var timeToMeeting: String {
        let timeInterval: TimeInterval = date.timeIntervalSinceNow
        return TimeInterval.daysFormatter.string(from: timeInterval + 60.0) ?? "----"
    }
}
