//
//  HomeView.swift
//  Habits
//
//  Created by Aryan Sharma on 22/11/24.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    @State private var selectedTab: Tab = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CloudyBackgroundView()
            VStack(spacing: 0) {
                TabView(selection: $selectedTab) {
                    NavigationStack {
                        HabitsView()
                            .tag(Tab.home)
                    }
                    Text("Courses")
                        .tag(Tab.courses)
                    Text("Community")
                        .tag(Tab.communityTab)
                    Text("Settings")
                        .tag(Tab.settings)
                }
                
                .padding(.bottom, 0)
                CustomTabBarView(selectedTab: $selectedTab)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    let congif = Realm.Configuration(inMemoryIdentifier:  UUID().uuidString)
        
    return HomeView()
        .environment(\.colorScheme, .light)
        .environment(\.realmConfiguration, congif)
}
