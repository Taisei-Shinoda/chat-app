//
//  SyncContactsView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/24.
//

import SwiftUI

struct SyncContactsView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @Binding var isOnbording: Bool
    
    var body: some View {
        
        VStack {
            Spacer()
            
            Image("onboarding-all-set")
            Text("Awesome!")
                .font(.titleText)
                .padding(.top, 32)
            
            Text("Continue to start chatting with your friends.")
                .font(.bodyParagraph)
                .padding(.top, 8)
            
            Spacer()
            
            Button {
                isOnbording = false
            } label: {
                Text("Continue")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            
        }
        .padding(.horizontal)
        .onAppear {
            contactsViewModel.getLocalContacts()
        }
    }
}

struct SyncContactsView_Previews: PreviewProvider {
    static var previews: some View {
        SyncContactsView(isOnbording: .constant(true))
    }
}
