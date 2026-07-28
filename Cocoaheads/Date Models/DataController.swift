//
//  DataController.swift
//  Cocoaheads
//
//  Created by Charlie Minow on 7/28/26.
//

import Foundation

@Observable class DataController {
    var meetings: [Meeting]

    let secondTuesdayComponents: DateComponents = DateComponents(hour: 18,
                                                                   minute: 30,
                                                                   second: 0,
                                                                   weekday: 3,
                                                                   weekdayOrdinal: 2)
    let calendar: Calendar = Calendar.current

    var nextMeetingDate: Date {
        let nextMeetingDate: Date = calendar.nextDate(after: .now,
                                                      matching: secondTuesdayComponents, matchingPolicy: .nextTimePreservingSmallerComponents) ?? .now
        return nextMeetingDate
    }

    var previousMeetingDate: Date? {
        guard let startDate: Date = calendar.date(byAdding: .day, value: -75, to: .now) else { return nil }
        var tempMeetingDays: [Date] = []
        var count: Int = 0
        calendar.enumerateDates(startingAfter: startDate,
                                matching: secondTuesdayComponents,
                                matchingPolicy: .previousTimePreservingSmallerComponents)
        { (date, match, stop) in
            if let date = date {
                if count >= 5 {
                    stop = true
                } else {
                    count += 1
                    tempMeetingDays.append(date)
                }
            }
        }
        for tempMeetingDay in tempMeetingDays.reversed() {
            if .now > tempMeetingDay {
                return tempMeetingDay
            }
        }
        return nil
    }

    var nextMeetingDateString: String {
        return DateFormatter.displayTime.string(from: nextMeetingDate)
    }

    var nextMeetingDateIntervalString: String {
        let timeInterval: TimeInterval = nextMeetingDate.timeIntervalSinceNow
        return TimeInterval.fancyFormatter.string(from: timeInterval) ?? "----"
    }

    func intervalStringForMeetingDate(at index: Int) -> String {
        if index < 1 {
            guard let timeInterval: TimeInterval = meetings.first?.date.timeIntervalSince(nextMeetingDate) else { return "????" }
            return TimeInterval.listIntervalFormatter.string(from: timeInterval) ?? "-"
        }
        let timeInterval: TimeInterval = meetings[index].date.timeIntervalSince(meetings[index - 1].date)
        
        return TimeInterval.listIntervalFormatter.string(from: timeInterval) ?? "----"
    }

    init() {
        self.meetings = []
        var count: Int = 0

        calendar.enumerateDates(startingAfter: nextMeetingDate,
                                matching: secondTuesdayComponents,
                                matchingPolicy: .nextTimePreservingSmallerComponents) { (date, match, stop) in
            if let date = date {
                if count >= 12 {
                    stop = true
                } else {
                    count += 1
                    meetings.append(Meeting(date: date))
                }
            }
        }
    }
}
