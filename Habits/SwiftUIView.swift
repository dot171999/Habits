//
//  SwiftUIView.swift
//  Habits
//
//  Created by Aryan Sharma on 22/11/24.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                NewHabitView()
            } label: {
                Image("PlusButton")
                    .resizable()
                    .frame(width: 65, height: 65)
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
