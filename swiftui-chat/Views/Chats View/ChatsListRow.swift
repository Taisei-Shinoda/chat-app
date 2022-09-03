//
//  ChatsListRow.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/09/03.
//

import SwiftUI

struct ChatsListRow: View {
    
    var chat: Chat
    
    var otherParticipants: [User]?
    
    var body: some View {
        
        HStack(spacing: 24) {
 
            let participant = otherParticipants?.first
            
            if participant != nil {
                // プロファイル画像
                ProfilePicView(user: participant!)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                // 名前
                Text(participant == nil ? "Unknown" :
                        "\(participant!.firstname ?? "") \(participant!.lastname ?? "")")
                    .font(.button)
                    .foregroundColor(Color("text-primary"))
                
                // 最後のメッセージ
                Text(chat.lastmsg ?? "")
                    .font(.bodyParagraph)
                    .foregroundColor(Color("text-input"))
            }
            Spacer()
            
            Text(chat.updated == nil ? "" : DateHelper.chatTimestampFrom(date: chat.updated!))
                .font(.bodyParagraph)
                .foregroundColor(Color("text-input"))
        }
        
    }
}

