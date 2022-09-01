//
//  Chat.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/31.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Chat: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var lastmsg: String?
    
    var numparticipants: Int
    
    var participantids: [String]
    
    @ServerTimestamp var updated: Date?
    
    var msgs: [ChatMessage]?
}




struct ChatMessage: Codable, Identifiable {
  
    @DocumentID var id: String?
    
    var imageurl: String?
    
    var msg: String
    
    @ServerTimestamp var timestamp: Date?
    
    var senderid: String?
    
}
