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
    
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State var isContactsPickerShowing = false
    
    @State var chatMessage = ""
    
    @State var participants = [User]()
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                //TODO: チャットヘッダー
                ZStack {
                    Color("view-header-background")
                        .ignoresSafeArea()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                            HStack {
                                Button {
                                    isChatShowing = false
                                } label: {
                                    Image(systemName: "arrow.backward")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color("text-header"))
                                }
                                if participants.count == 0 {
                                    Text("New Message")
                                        .font(.chatHeading)
                                        .foregroundColor(Color("text-header"))
                                }
                            }
                            .padding(.bottom, 16)
                            
                            // 連絡先の名前
                            if participants.count > 0 {
                                let participant = participants.first
                                
                                Group {
                                    if participants.count == 1 {
                                        Text("\(participant?.firstname ?? "") \(participant?.lastname ?? "")")
                                    }
                                    else if participants.count == 2 {
                                        
                                        let participant2 = participants[1]
                                        
                                        Text("\(participant?.firstname ?? ""), \(participant2.firstname ?? "")")
                                            
                                    }
                                    else if participants.count > 2 {
                                        
                                        let participant2 = participants[1]
                                        
                                        Text("\(participant?.firstname ?? ""), \(participant2.firstname ?? "") + \(participants.count - 2) others")
                                    }
                                }
                                .font(.chatHeading)
                                .foregroundColor(Color("text-header"))
                            }
                            else {
                                Text("Recipient")
                                    .font(.bodyParagraph)
                                    .foregroundColor(Color("text-input"))
                            }
                        }
                        Spacer()
                        
                        // 連絡先のサムネイル画像
                        if participants.count == 1 {
                            let participant = participants.first
                            ProfilePicView(user: participant!)
                        }
                        else if participants.count > 1 {
                            GroupProfilePicView(users: participants)
                        }
                        else {
                            // 新しいメッセージを開始
                            Button {
                                
                                isContactsPickerShowing = true
                                
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color("button-primary"))
                                    .frame(width: 25, height: 25)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 104)
                
                //TODO: チャットログ
                ScrollViewReader { proxy in
                    ScrollView {
                        
                        VStack (spacing: 24){
                            
                            ForEach(Array(chatViewModel.messages.enumerated()), id: \.element) { index, msg in
                                
                                let isFromUser = msg.senderid == AuthViewModel.getLoggedInUserId()
                                
                                // 動的メッセージ
                                HStack {
                                    if isFromUser {
                                        Text(DateHelper.chatTimestampFrom(date: msg.timestamp))
                                            .font(.smallText)
                                            .foregroundColor(Color("text-timestamp"))
                                            .padding(.trailing)
                                        
                                        Spacer()
                                    }
                                    else if participants.count > 1 {
                                        
                                        let userOfMsg = participants.filter { p in p.id == msg.senderid }.first
                                        if let userOfMsg = userOfMsg {
                                            ProfilePicView(user: userOfMsg)
                                                .padding(.trailing, 16)
                                        }
                                    }
                                    
                                    
                                    
                                    if msg.imageurl != "" {
                                        // 画像メッセージ
                                        ConversationPhotoMessage(imageUrl: msg.imageurl!, isFromUser: isFromUser)
                                    }
                                    else {
                                        // テキストメッセージ
                                        
                                        if participants.count > 1 && !isFromUser {
                                            let userOfMsg = participants.filter { p in p.id == msg.senderid }.first
                                            ConversationTextMessage(msg: msg.msg,
                                                                    isFromUser: isFromUser,
                                                                    name: "\(userOfMsg?.firstname ?? "") \(userOfMsg?.lastname ?? "")")
                                        }
                                        else {
                                            
                                            ConversationTextMessage(msg: msg.msg, isFromUser: isFromUser)
                                        }
                                    }
                                    if !isFromUser {
                                        Spacer()
                                        
                                        Text(DateHelper.chatTimestampFrom(date: msg.timestamp))
                                            .font(.smallText)
                                            .foregroundColor(Color("text-timestamp"))
                                            .padding(.leading)
                                    }
                                }
                                .id(index)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 24)
                    }
                    .onChange(of: chatViewModel.messages.count) { newCount in
                        withAnimation {
                            proxy.scrollTo(newCount - 1)
                        }
                    }
                }
                
                //TODO: チャットメッセージバー
                HStack(spacing: 10) {
                    Button {
                        // TODO: ピッカー
                        isSourceMenuShowing = true
                        
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
                        
                        if selectedImage != nil {
                            Text("Image")
                                .foregroundColor(Color("text-input"))
                                .font(.bodyParagraph )
                                .padding(10)
                            
                            HStack {
                                Spacer()
                                
                                Button {
                                    selectedImage = nil
                                    
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color("text-input"))
                                }
                            }
                            .padding(.trailing, 12)
                            
                        }
                        else {
                            TextField("Aa", text: $chatMessage)
                                .foregroundColor(Color("text-input"))
                                .font(.bodyParagraph )
                                .padding(10)
                        }
                    }
                    .frame(height: 44)
                    
                    Button {
                        
                        //TODO: 画像を選択した場合、画像を送信してください
                        if selectedImage != nil {
                            chatViewModel.sendPhotoMessage(image: selectedImage!)
                            selectedImage = nil
                            
                        }
                        else {
                            //TODO: メッセージの初期化
                            chatMessage = chatMessage.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            //TODO: メッセージを送ります
                            chatViewModel.sendMessage(msg: chatMessage)
                            chatMessage = ""
                        }
                        
                    } label: {
                        Image(systemName: "paperplane")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-primary"))
                    }
                    .disabled(chatMessage.trimmingCharacters(in: .whitespacesAndNewlines) == "" && selectedImage == nil)
                }
                .disabled(participants.count == 0)
                .padding(.horizontal)
                .frame(height: 76)
            }
        }
        .onAppear {
            chatViewModel.getMessages()
            
            let ids = chatViewModel.getParticipantIds()
            self.participants = contactsViewModel.getParticipants(ids: ids)
        }
        .onDisappear() {
            chatViewModel.conversationViewCleanup()
        }
        .confirmationDialog("From Where", isPresented: $isSourceMenuShowing, actions: {
            
            Button {
                // Set the SOORCE
                self.source = .photoLibrary
                isPickerShowing = true
            } label: {
                Text("Photo Library")
            }
            
            /// シミュレーターにはカメラ機能がないので、クラッシュ防止のためこのメソッドを書きました。
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                Button {
                    // Set the SOORCE
                    self.source = .camera
                    isPickerShowing = true
                } label: {
                    Text("Take Photo")
                }
            }
        })
        .sheet(isPresented: $isPickerShowing) {
            // TODO: ImagePicker を表示します
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: self.source)
        }
        .sheet(isPresented: $isContactsPickerShowing) {
            
            chatViewModel.getChatFor(contacts: participants)
            
        } content: {
            ContactsPicker(isContactsPickerShowing: $isContactsPickerShowing,
                           selectedContacts: $participants)
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
