//
//  ChatsListView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/29.
//

import SwiftUI

struct ChatsListView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var isChatShowing: Bool
    
    @Binding var isSettingsShowing: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Chats")
                    .font(.pageTitle)
                Spacer()
                Button {
                    // 設定
                    isSettingsShowing = true
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icons-secondary"))
                }
            }
            .padding(.top, 20)
            .padding(.horizontal)
            
            
            if chatViewModel.chats.count > 0 {
                List(chatViewModel.chats) { chat in
                    
                    let otherParticipants = contactsViewModel.getParticipants(ids: chat.participantids)
                    
                    if let otherParticipant = otherParticipants.first, chat.numparticipants == 2, !otherParticipant.isactive {
                        
                        // 削除されたアカウントとの会話は表示させません
                        
                    }
                    else {
                        Button {
                            chatViewModel.selectedChat = chat
                            isChatShowing = true
                        } label: {
                            ChatsListRow(chat: chat,
                                         otherParticipants: otherParticipants)
                        }
                        .buttonStyle(.plain)
                        .listRowBackground(Color(.clear))
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
            else {
                Spacer()
                
                Image("no-chats-yet")
                Text("まだチャットはない....")
                    .font(.titleText)
                    .padding(.top, 32)
                
                Text("友だちとチャットを始める")
                    .font(.bodyParagraph)
                    .padding(.top, 8)
                
                Spacer()
            }
        }
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView(isChatShowing: .constant(false), isSettingsShowing: .constant(false))
    }
}
