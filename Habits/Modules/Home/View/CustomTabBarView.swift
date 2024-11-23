//
//  CustomTabBarView.swift
//  Habits
//
//  Created by Aryan Sharma on 22/11/24.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        ZStack(alignment: .center) {
            Image("TabBarBackground")
                .resizable()
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    if tab != .none {
                        Image(tab.rawValue)
                            .saturation(selectedTab == tab ? 1 : 0)
                            .onTapGesture {
                                withAnimation {
                                    selectedTab = tab
                                }
                            }
                    } else {
                        Rectangle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.clear)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 100, alignment: .top)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.home))
}
