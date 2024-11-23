//
//  CustomToggleView.swift
//  Habits
//
//  Created by Aryan Sharma on 22/11/24.
//

import SwiftUI

struct CustomToggleView<Label>: View where Label: View {
    @Binding var isOn: Bool
    let label: () -> Label
    
    var body: some View {
        HStack {
            label()
            Spacer()
            
            HStack(spacing: 0) {
                Text(isOn ? "On" : "")
                    .font(.system(size: 10))
                    .fontWeight(.medium)
                Circle()
                    .frame(width: 22)
                    .padding(.horizontal, 4)
                    .shadow(color: Color("FontColorPurple").opacity(0.3), radius: 4, x: -5, y: 5)
                
                Text(isOn ? "" : "Off")
                    .font(.system(size: 10))
                    .fontWeight(.medium)
            }
            .frame(width: 55, height: 30, alignment: isOn ? .trailing : .leading)
            .background(Capsule().foregroundStyle(Color("ButtonBackColor")))
            .onTapGesture {
                withAnimation {
                    isOn.toggle()
                }
            }
            .foregroundStyle(Color("FontColorPurple"))
        }
    }
}

#Preview {
    CustomToggleView(isOn: .constant(false), label: {
        Text("Label")
    })
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .padding(.vertical)
}
