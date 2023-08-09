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
            Text("素晴らしい！")
                .font(.titleText)
                .padding(.top, 32)
            
            Text("チャットを続ける")
                .font(.bodyParagraph)
                .padding(.top, 8)
            
            Spacer()
            
            Button {
                isOnbording = false
            } label: {
                Text("続ける")
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
