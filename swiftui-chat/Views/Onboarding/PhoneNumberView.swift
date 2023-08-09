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
    
    @State var isButtonDisabled = false
    
    @State var isErrorLabelVisible = false
    
    var body: some View {
        
        VStack {
            
            Text("検証")
                .font(.titleText)
                .padding(.top, 52)
            
            Text("携帯電話番号を入力してください。確認コードをお送りします。")
                .font(.bodyParagraph)
                .padding(.top, 12)
            
            ZStack {
                Rectangle()
                    .frame(height: 52)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("e.g. +1 613 515 0123",text: $phoneNumber)
                        .foregroundColor(Color("text-textfield"))
                        .font(.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(phoneNumber)) { _ in
                            TextHelper.applyPatternOnNumbers(&phoneNumber,
                                                             pattern: "+X (XXX) XXX-XXXX",
                                                             replacementCharacter: "X")
                        }
                        .placeholder(when: phoneNumber.isEmpty) {
                            Text("e.g. +1 613 515 0123")
                                .foregroundColor(Color("text-textfield"))
                                .font(.bodyParagraph)
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
            
            // エラーラベル
            Text("有効な電話番号を入力してください")
                .foregroundColor(.red)
                .font(.smallText)
                .padding(.top, 20)
                .opacity(isErrorLabelVisible ? 1 : 0)
            
            Spacer()
            
            Button {
                
                isErrorLabelVisible = false
                
                isButtonDisabled = true
                
                //TODO: Firebase へ電話認証を依頼
                AuthViewModel.sendPhoneNumber(phone: phoneNumber) { error in
                    if error == nil {
                        currentStep = .verification
                    } else {
                        // TODO: エラーを見せる
                        isErrorLabelVisible = true
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

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(currentStep: .constant(.phonenumber))
    }
}
