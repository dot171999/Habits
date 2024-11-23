//
//  CloudyBackgroundView.swift
//  Habits
//
//  Created by Aryan Sharma on 22/11/24.
//

import SwiftUI

struct CloudyBackgroundView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("Background")
            Image("CloudBackground")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CloudyBackgroundView()
}
