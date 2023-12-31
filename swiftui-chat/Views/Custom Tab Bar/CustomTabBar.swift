//
//  CustomTabBar.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/22.
//

import SwiftUI

enum Tabs: Int {
    case chats = 0
    case contacts = 1
}



struct CustomTabBar: View {
    
    @Binding var selectedTabs: Tabs
    @Binding var isChatShowing: Bool
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    var body: some View {
        HStack (alignment: .center) {
            
            Button {
                selectedTabs = .chats
            } label: {
                
                TabBarButton(buttonText: "Chats",
                             imageName: "bubble.left",
                             isActive: selectedTabs == .chats)
                
            }
            .tint(Color("icons-secondary"))
            
            
            Button {
                
                chatViewModel.clearSelectedChat()
                
                isChatShowing = true
                
            } label: {
                
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    
                    Text("New Chats")
                        .font(.tabBar)
                }
            }
            .tint(Color("icons-primary"))
            
            
            Button {
                selectedTabs = .contacts
            } label: {
                TabBarButton(buttonText: "Contacts",
                             imageName: "person",
                             isActive: selectedTabs == .contacts)
            }
            .tint(Color("icons-secondary"))
            
        }
        .frame(height: 82)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTabs: .constant(.chats), isChatShowing: .constant(false))
    }
}
