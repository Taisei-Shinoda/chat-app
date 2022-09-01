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
}


