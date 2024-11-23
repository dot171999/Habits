//
//  HabitsApp.swift
//  Habits
//
//  Created by Aryan Sharma on 22/11/24.
//

import SwiftUI

@main
struct HabitsApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.colorScheme, .light)
        }
    }
}
