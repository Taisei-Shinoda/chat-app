//
//  VerificationView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/24.
//

import SwiftUI

struct VerificationView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var VerificationCode = ""
    
    var body: some View {
        
        VStack {
            
            Text("Verification")
                .font(.titleText)
                .padding(.top, 52)
            
            Text("We sent a 6-digit verification code to your device.")
                .font(.bodyParagraph)
                .padding(.top, 12)
            
            // textFIeld
            ZStack {
                Rectangle()
                    .frame(height: 52)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("", text: $VerificationCode)
                        .font(.bodyParagraph)
                    
                    
                    Spacer()
                    
                    Button {
                        VerificationCode = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .frame(width: 19, height: 19)
                    .tint(Color("icons-input"))
                }
                .padding()
            }
            .padding(.top, 34)
            
            Spacer()
            
            Button {
                currentStep = .profile
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
        }
        .padding(.horizontal)
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep: .constant(.verification))
    }
}
