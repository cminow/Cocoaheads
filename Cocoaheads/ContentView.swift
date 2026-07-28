//
//  ContentView.swift
//  Cocoaheads
//
//  Created by Charlie Minow on 7/28/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(DataController.self) private var dataController
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        VStack {
            Text("Next Cocoaheads Meeting")
                .foregroundStyle(colorScheme == .light ? .black : .white)
                .opacity(0.750)
                .font(.system(size: 20.0).smallCaps().bold())
            TimelineView(.periodic(from: .now, by: 1.0)) { context in
                Text("\(dataController.nextMeetingDateString)")
                    .font(.system(.title).bold())
                Text("\(dataController.nextMeetingDateIntervalString)")
                    .monospacedDigit()
                if let previousMeetingDate = dataController.previousMeetingDate {
                    MyProgressView(previousMeetingDate: previousMeetingDate,
                                   nextMeetingDate: dataController.nextMeetingDate,
                                   currentTime: context.date)
                        .frame(maxWidth: .infinity, maxHeight: 16.0)
                        .shadow(color: .primary.opacity(0.5), radius: 12.0)
                        .padding([.leading, .trailing], 18.0)
                }
            }
            
            List {
                Section {
                    ForEach(dataController.meetings.indices, id: \.self) { index in
                        HStack(alignment: .lastTextBaseline) {
                            Text(dataController.intervalStringForMeetingDate(at: index))
                            Spacer()
                            Text(dataController.meetings[index].stringValue)
                                .bold()
                        }
                    }
                } header: {
                    Text("Future Meetings")
                }
            }
            .environment(\.defaultMinListRowHeight, 0)
            .scrollContentBackground(.hidden)
            .shadow(color: .primary.opacity(0.5), radius: 12.0)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
