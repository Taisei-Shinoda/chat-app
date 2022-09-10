//
//  ChatViewModel.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/31.
//

import Foundation
import SwiftUI


class ChatViewModel: ObservableObject {
    
    @Published var chats = [Chat]()
    
    @Published var selectedChat: Chat?
    
    @Published var messages = [ChatMessage]()
    
    var databaseService = DatabaseService()
    
    init() {
        getChats()
    }
    

    func getChats() {
        databaseService.getAllChats { chats in
            self.chats = chats
        }
    }
    
    func getChatFor(contact: User) {
        guard contact.id != nil else {
            return
        }
        let foundChat = chats.filter { chat in
            return chat.numparticipants == 2 && chat.participantids.contains(contact.id!)
        }
        
        if !foundChat.isEmpty {
            
            self.selectedChat = foundChat.first!
            getMessages()
            
        } else {
            var newChat = Chat(id: nil, numparticipants: 2, participantids: [AuthViewModel.getLoggedInUserId(), contact.id!],
                               lastmsg: nil, updated: nil, msgs: nil)
            
            self.selectedChat = newChat
            
            databaseService.createChat(chat: newChat) { docId in
                self.selectedChat = Chat(id: docId, numparticipants: 2,
                                         participantids: [AuthViewModel.getLoggedInUserId(), contact.id!],
                                         lastmsg: nil, updated: nil, msgs: nil)
                self.chats.append(self.selectedChat!)
            }
        }
    }
    
    func getMessages() {
        guard selectedChat != nil else {
            return
        }
        databaseService.getAllMessages(chat: selectedChat!) { msgs in
            self.messages = msgs
        }
    }
    
    
    func sendMessage(msg: String) {
        
        guard selectedChat != nil else {
            return
        }
        databaseService.sendMessage(msg: msg, chat: selectedChat!)
    }
  
    
    func sendPhotoMessage(image: UIImage) {
        
        guard selectedChat != nil else {
            return
        }
        databaseService.sendPhotoMessage(image: image, chat: selectedChat!)
    }
    
    
    func conversationViewCleanup() {
        databaseService.detachConversationViewListeners()
    }
    
    
    func chatListViewCleanup() {
        databaseService.detachChatListViewListeners()
    }
    
    
    // MARK: - Helper Methods
    
    func getParticipantIds() -> [String] {
        
        guard selectedChat != nil else {
            return [String]()
        }
        
        let ids = selectedChat!.participantids.filter { id in
            id != AuthViewModel.getLoggedInUserId()
        }
        return ids
    }
}


