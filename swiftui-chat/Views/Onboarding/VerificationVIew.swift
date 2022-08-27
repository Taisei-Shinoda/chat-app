//
//  VerificationView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/24.
//

import SwiftUI
import Combine

struct VerificationView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var verificationCode = ""
    
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
                    TextField("", text: $verificationCode)
                        .font(.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(verificationCode)) { _ in
                            TextHelper.limitText(&verificationCode, 6)
                        }
                    
                    
                    Spacer()
                    
                    Button {
                        verificationCode = ""
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
                AuthViewModel.verifyCode(code: verificationCode) { error in
                    if error == nil {
                        currentStep = .profile
                    } else {
                        // TODO: エラーメッセージを表示
                        
                    }
                }
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
