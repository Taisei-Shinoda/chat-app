//
//  CreateProfileView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/24.
//

import SwiftUI

struct CreateProfileView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var firstName  = ""
    @State var lastName  = ""
    
    var body: some View {
        VStack {
            
            Text("Setup your Profile")
                .font(.titleText)
                .padding(.top, 52)
            
            Text("Just a few more details to get started.")
                .font(.bodyParagraph)
                .padding(.top, 12)
            
            Spacer()
            
            // profile image buttton
            Button {
                //
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    Circle()
                        .stroke(Color("create-profile-border"), lineWidth: 2)
                    
                    Image(systemName: "camera.fill")
                        .tint(Color("icons-input"))
                }
                .frame(width: 134, height: 134)
            }

            Spacer()
        
            TextField("Given Name", text: $firstName)
                .textFieldStyle(CreateProfileTextfieldStyle())
            
            TextField("Given Name", text: $lastName)
                .textFieldStyle(CreateProfileTextfieldStyle())
            
            Spacer()
            
            Button {
                currentStep = .contacts
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
        }
        .padding(.horizontal)
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(currentStep: .constant(.profile))
    }
}
