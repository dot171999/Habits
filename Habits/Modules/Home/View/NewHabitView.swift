//
//  NewHabitView.swift
//  Habits
//
//  Created by Aryan Sharma on 22/11/24.
//

import SwiftUI

struct NewHabitView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: NewHabitViewModel = NewHabitViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CloudyBackgroundView()
            VStack(spacing: 0) {
                Header()
                HabitTextField()
                    .padding(.vertical)
                CustomDatePicker()
                    .padding(.bottom)
                CustomNotificationToggle()
                Spacer()
                VStack {
                    Image("MessagePopup")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Button(action: {
                        
                    }, label: {
                        Image("CheckButton")
                            .resizable()
                            .frame(width: 65, height: 65)
                    })
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
        .alert("Error", isPresented: $viewModel.showErrorAlert, actions: {
            Button("OK", role: .none) {
                viewModel.resetErrorMessage()
            }
        }, message: {
            Text(viewModel.errorMessage)
        })
    }
    
    @ViewBuilder
    func CustomNotificationToggle() -> some View {
        CustomToggleView(isOn: $viewModel.inputNotifToggle, label: {
            Text("Notification")
                .foregroundStyle(Color("FontColorPurple"))
        })
        .padding(.horizontal)
        .frame(height: 50)
        .background(.white)
        .clipShape(.rect(cornerRadius: 12))
    }
    
    @ViewBuilder
    func CustomDatePicker() -> some View {
        HStack(alignment: .center) {
            Text("Reminder")
                .foregroundStyle(Color("FontColorPurple"))
            Spacer()
            Text(viewModel.inputDate.formatted(.dateTime.hour().minute()))
                .fontWeight(.medium)
                .foregroundStyle(Color("orangeColour"))
            Image(systemName: "chevron.right")
                .renderingMode(.template)
                .foregroundStyle(Color("orangeColour"))
                .shadow(color: Color("orangeColour"), radius: 5, x: 0.0, y: 0.0)
                .fontWeight(.bold)
        }
        .overlay {
            DatePicker(selection: $viewModel.inputDate, displayedComponents: .hourAndMinute) {
                Text("")
                    .foregroundStyle(Color("FontColorPurple"))
            }
            .colorMultiply(.clear)
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(.white)
        .clipShape(.rect(cornerRadius: 12))
    }
    
    @ViewBuilder
    func HabitTextField() -> some View {
        HStack {
            TextField("Enter habit name", text: $viewModel.inputHabitName)
                .frame(maxWidth: .infinity , maxHeight: .infinity)
                .padding(.leading, 20)
                .background(.white)
                .clipShape(.rect(cornerRadius: 12))
            
            Button(action: {
                Task {
                    let isSuccess = await viewModel.createNewHabit()
                    if isSuccess {
                        await MainActor.run {
                            dismiss()
                        }
                    }
                }
            }, label: {
                Image("fa-solid_book-reader")
                
            })
            .frame(maxWidth: 50 ,maxHeight: .infinity)
            .background(.white)
            .clipShape(.rect(cornerRadius: 12))
            .overlay(alignment: .topTrailing) {
                Image("akar-icons_circle-plus-fill")
                    .alignmentGuide(.top) { $0[.top] + ($0.height / 2) - 5 }
                    .alignmentGuide(.trailing) { $0[.trailing] - ($0.width / 2) + 5 }
            }
        }
        .frame(height: 50)
    }
    
    @ViewBuilder
    func Header() -> some View {
        HStack {
            Button(action: {
                dismiss()
            }, label: {
                Image("BackIcon")
                    .frame(width: 44, height: 44)
                    .background(Circle().foregroundStyle(Color("ButtonBackColor")))
            
            })
            Spacer()
        }
        .overlay {
            Text("New Habit")
                .foregroundStyle(Color("FontColorPurple"))
                .fontWeight(.semibold)
                
        }
    }
    
    @ViewBuilder
    func Background() -> some View {
        Color("Background")
            .ignoresSafeArea()
        Image("CloudBackground")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    NewHabitView()
}
