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
                .opacity(0.5)
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
                        .listRowInsets(.init(top: 13.0, leading: 20.0, bottom: 12.0, trailing: 20.0))
                        .listRowBackground((index % 2 == 0) ? Color(.systemGray).opacity(0.3) : Color(.systemGray).opacity(0.35))
                    }
                } header: {
                    Text("Future Meetings")
                        .foregroundStyle(colorScheme == .light ? .black : .white)
                        .font(.subheadline.bold().smallCaps())
                }
            }
            .environment(\.defaultMinListRowHeight, 0)
            .scrollContentBackground(.hidden)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
