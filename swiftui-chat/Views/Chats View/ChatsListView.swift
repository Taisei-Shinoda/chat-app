//
//  ChatsListView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/29.
//

import SwiftUI

struct ChatsListView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    var body: some View {
        
        if chatViewModel.chats.count > 0 {
            List(chatViewModel.chats) { chat in
                Text(chat.id ?? "空のチャットID")
            }
        } else {
            Text("No Chats")
        }
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView()
    }
}
