//
//  WelcomeView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/24.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var currentStep: OnboardingStep
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image("onboarding-welcome")
            Text("Welcome to Chat App")
                .font(.titleText)
                .padding(.top, 32)
            
            Text("シンプルなチャット体験")
                .font(.bodyParagraph)
                .padding(.top, 8)
            
            Spacer()
            
            Button {
                currentStep = .phonenumber
            } label: {
                Text("始めましょう")
            }
            .buttonStyle(OnboardingButtonStyle())
            
            Text("「続行」をタップすると、プライバシーポリシーに同意したことになります。")
                .font(.smallText)
                .padding(.top, 14)
                .padding(.bottom, 61)
            
        }
        .padding(.horizontal)
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(currentStep: .constant(.welcome))
        
    }
}
