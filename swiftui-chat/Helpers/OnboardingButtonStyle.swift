//
//  OnboardingButtonStayle.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/24.
//

import Foundation
import SwiftUI


struct OnboardingButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .frame(height: 50)
                .cornerRadius(4)
                .foregroundColor(Color("button-primary"))
            
            configuration.label
                .font(.button)
                .foregroundColor(Color("text-button"))
        }
    }
}
