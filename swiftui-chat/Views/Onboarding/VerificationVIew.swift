//
//  VerificationView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/24.
//

import SwiftUI
import Combine

struct VerificationView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var currentStep: OnboardingStep
    @Binding var isOnboarding: Bool
    
    @State var verificationCode = ""
    
    @State var isButtonDisabled = false
    
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
                isButtonDisabled = true
                
                AuthViewModel.verifyCode(code: verificationCode) { error in
                    
                    if error == nil {
                        DatabaseService().checkUserProfile { exists in
                            if exists {
                                isOnboarding = false
                                
                                // ログアウトした後の、コンテンツのロード
                                contactsViewModel.getLocalContacts()
                                chatViewModel.getChats()
                                
                            } else {
                                currentStep = .profile
                            }
                        }
                    }
                    else {
                        // TODO: エラーメッセージを表示
                        
                    }
                    isButtonDisabled = false
                }
            } label: {
                HStack {
                    Text("Next")
                    if isButtonDisabled {
                        ProgressView()
                            .padding(.leading, 2)
                    }
                }
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            .disabled(isButtonDisabled)
        }
        .padding(.horizontal)
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep: .constant(.verification), isOnboarding: .constant(true))
    }
}
