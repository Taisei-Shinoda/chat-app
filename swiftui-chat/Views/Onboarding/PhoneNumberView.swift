//
//  PhoneNumberView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/24.
//

import SwiftUI
import Combine


struct PhoneNumberView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var phoneNumber = ""
    
    var body: some View {
        
        VStack {
            
            Text("Verification")
                .font(.titleText)
                .padding(.top, 52)
            
            Text("Enter your mobile number below. We’ll send you a verification code after.")
                .font(.bodyParagraph)
                .padding(.top, 12)
            
            ZStack {
                Rectangle()
                    .frame(height: 52)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("e.g. +1 613 515 0123",text: $phoneNumber)
                        .font(.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(phoneNumber)) { _ in
                            TextHelper.applyPatternOnNumbers(&phoneNumber,
                                                             pattern: "+X (XXX) XXX-XXXX",
                                                             replacementCharacter: "X")
                        }
                    
                    Spacer()
                    
                    Button {
                        phoneNumber = ""
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
                //TODO: Firebase へ電話認証を依頼
                AuthViewModel.sendPhoneNumber(phone: phoneNumber) { error in
                    if error == nil {
                        currentStep = .verification
                    } else {
                        
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

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(currentStep: .constant(.phonenumber))
    }
}
