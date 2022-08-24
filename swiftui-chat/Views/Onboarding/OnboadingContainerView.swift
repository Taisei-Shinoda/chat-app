//
//  OnboadingContainerView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/24.
//

import SwiftUI


/// オンボーディングの画面を列挙型で並べます。そして各ビューの　＠Biding　で紐づけていきます。
enum OnboardingStep: Int {
    case welcome = 0
    case phonenumber = 1
    case verification = 2
    case profile = 3
    case contacts = 4
}


struct OnboadingContainerView: View {
    
    @Binding var isOnbording: Bool
    @State var currentStep: OnboardingStep = .welcome
    
    var body: some View {
        ZStack {
            
            Color("background")
                .ignoresSafeArea(edges: [.top, .bottom])
            
            switch currentStep {
            case .welcome:
                WelcomeView(currentStep: $currentStep)
                
            case .phonenumber:
                PhoneNumberView(currentStep: $currentStep)
                
            case .verification:
                VerificationView(currentStep: $currentStep)
                
            case .profile:
                CreateProfileView(currentStep: $currentStep)
                
            case .contacts:
                SyncContactsView(isOnbording: $isOnbording)
            }
        }
    }
}

struct OnboadingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboadingContainerView(isOnbording: .constant(true))
    }
}
