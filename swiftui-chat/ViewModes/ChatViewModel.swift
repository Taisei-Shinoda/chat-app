//
//  ChatViewModel.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/31.
//

import Foundation
import SwiftUI


class ChatViewModel: ObservableObject {
    
    var chats = [Chat]()
    
    var datebaseService = DatabaseService()
    
    init() {
        getChats()
    }

    func getChats() {
        datebaseService.getAllChats { chats in
            self.chats = chats
        }
    }
}


