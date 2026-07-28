//
//  CocoaheadsApp.swift
//  Cocoaheads
//
//  Created by Charlie Minow on 7/28/26.
//

import SwiftUI

@main
struct CocoaheadsApp: App {
    @State var dataController: DataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataController)
        }
    }
}
