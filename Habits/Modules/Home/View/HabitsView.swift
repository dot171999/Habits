//
//  HabitsView.swift
//  Habits
//
//  Created by Aryan Sharma on 22/11/24.
//

import SwiftUI
import RealmSwift

struct HabitsView: View {
    @ObservedResults(Habit.self) private var habits
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CloudyBackgroundView()
            VStack(spacing: 0) {
                Header()
                    .padding(.bottom)
                Image("Quote")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                List {
                    Section("Habits") {
                        ForEach (habits, id: \.self) { habit in
                            Text(habit.name)
                        }
                    }
                }
                .padding(.top)
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                NavigationLink {
                    NewHabitView()
                } label: {
                    Image("PlusButton")
                        .resizable()
                        .frame(width: 65, height: 65)
                }
            }
            .padding(.horizontal)
        }
    }
 
    @ViewBuilder
    func Header() -> some View {
        HStack {
            Button(action: {
                
            }, label: {
                Image("HamburgerMenu")
                    .frame(width: 44, height: 44)
                    .background(Circle().foregroundStyle(Color("ButtonBackColor")))
                
            })
            Spacer()
        }
        .overlay {
            Text("Homepage")
                .foregroundStyle(Color("FontColorPurple"))
                .fontWeight(.semibold)
            
        }
    }
}

#Preview {
    let congif = Realm.Configuration(inMemoryIdentifier:  UUID().uuidString)
    return NavigationStack {
        HabitsView()
            .environment(\.realmConfiguration, congif)
    }
}
