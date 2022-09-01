//
//  ConversationView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/31.
//

import SwiftUI

struct ConversationView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var isChatShowing: Bool
    @State var chatMessage = ""
    
    @State var participants = [User]()
    
    var body: some View {
        VStack(spacing: 0) {
            
            //TODO: チャットヘッダー
            HStack {
                VStack(alignment: .leading) {
                    Button {
                        isChatShowing = false
                    } label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color("text-header"))
                    }
                    .padding(.bottom, 16)
                    
                    // 連絡先の名前
                    if participants.count > 0 {
                        let participant = participants.first
                        Text("\(participant?.firstname ?? "") \(participant?.lastname ?? "")")
                            .font(.chatHeading)
                            .foregroundColor(Color("text-header"))
                        
                    }
                }
                Spacer()
                
                // 連絡先のサムネイル画像
                if participants.count > 0 {
                    let participant = participants.first
                    ProfilePicView(user: participant!)
                }
            }
            .padding(.horizontal)
            .frame(height: 104)
            
            //TODO: チャットログ
            ScrollView {
                
                VStack (spacing: 24){
                    
                    ForEach(chatViewModel.messages) { msg in
                        
                        let isFromUser = msg.senderid == AuthViewModel.getLoggedInUserId()
                        
                        HStack {
                            
                            if isFromUser {
                                Text(DateHelper.chatTimestampFrom(date: msg.timestamp))
                                    .font(.smallText)
                                    .foregroundColor(Color("text-timestamp"))
                                    .padding(.trailing)
                                
                                Spacer()
                            }
                            
                            Text(msg.msg)
                                .font(.bodyParagraph)
                                .foregroundColor(isFromUser ? Color("text-button") : Color("text-primary"))
                                .padding(.vertical, 16)
                                .padding(.horizontal, 24)
                                .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                                .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                            
                            if !isFromUser {
                                Spacer()
                                
                                Text(DateHelper.chatTimestampFrom(date: msg.timestamp))
                                    .font(.smallText)
                                    .foregroundColor(Color("text-timestamp"))
                                    .padding(.leading)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 24)
            }
            .background(Color("background"))
            
            //TODO: メッセージバー
            ZStack {
                Color("background")
                    .ignoresSafeArea()
        
                HStack(spacing: 10) {
                    Button {
                        // TODO: ピッカー
                    } label: {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-secondary"))
                    }
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color("date-pill"))
                            .cornerRadius(50)
                        
                        TextField("Aa", text: $chatMessage)
                            .foregroundColor(Color("text-input"))
                            .font(.bodyParagraph )
                            .padding(10)
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                //
                            } label: {
                                Image(systemName: "face.smiling")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color("text-input"))
                            }
                        }
                        .padding(.trailing, 12)
                        
                    }
                    .frame(height: 44)
                    
                    HStack {
                    Button {
                        //TODO: メッセージの初期化
                        
                        
                        //TODO: メッセージを送ります
                        chatViewModel.sendMessage(msg: chatMessage)
                        chatMessage = ""
                        
                    } label: {
                        Image(systemName: "paperplane")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-secondary"))
                    }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 76)
        }
        .onAppear {
            chatViewModel.getMessages()
            
            let ids = chatViewModel.getParticipantIds()
            self.participants = contactsViewModel.getParticipants(ids: ids)
        }
        
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(false))
    }
}


/*
 
 // 相手のメッセージ
 HStack {
     Text("相手のメッセージ")
         .font(.bodyParagraph)
         .foregroundColor(Color("text-primary"))
         .padding(.vertical, 16)
         .padding(.horizontal, 24)
         .background(Color("bubble-secondary"))
         .cornerRadius(30, corners: [.topLeft, .topRight, .bottomRight])
     
     Spacer()
     
     Text("9:41")
         .font(.smallText)
         .foregroundColor(Color("text-timestamp"))
         .padding(.leading)
 }
 
 // あなたのメッセージ
 HStack {
     Text("9:41")
         .font(.smallText)
         .foregroundColor(Color("text-timestamp"))
         .padding(.trailing)
     
         Spacer()
     
     Text("あなたのメッセージ")
         .font(.bodyParagraph)
         .foregroundColor(Color("text-button"))
         .padding(.vertical, 16)
         .padding(.horizontal, 24)
         .background(Color("bubble-primary"))
         .cornerRadius(30, corners: [.topLeft, .topRight, .bottomLeft])

 }

 
 */
