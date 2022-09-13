//
//  ConversationTextMessage.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/09/10.
//

import SwiftUI

struct ConversationTextMessage: View {
    
    var msg: String
    var isFromUser: Bool
    var name: String?
    var isActive: Bool = true
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            
            if let name = name {
                Text(name)
                    .font(.chatName)
                    .foregroundColor(Color("bubble-primary"))
            }
            
            Text(isActive ? msg : "Message Deleted")
                .font(.bodyParagraph)
                .foregroundColor(isFromUser ? Color("text-button") : Color("text-secondary"))
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
        .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
        
    }
}


struct ConversationTextMessage_Previews: PreviewProvider {
    static var previews: some View {
        ConversationTextMessage(msg: "", isFromUser: true)
    }
}
