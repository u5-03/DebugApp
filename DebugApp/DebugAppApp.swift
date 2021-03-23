//
//  DebugAppApp.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/23.
//

import SwiftUI

@main
struct DebugAppApp: App {
    var body: some Scene {
        WindowGroup {
            if UIApplication.shared.isInUnitTests {
                EmptyView()
            } else {
                ContentView()
            }
        }
    }
}
