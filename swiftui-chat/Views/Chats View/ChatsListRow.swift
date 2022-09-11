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
            
            if otherParticipants != nil && otherParticipants!.count == 1 {
                if participant != nil {
                    // プロファイル画像
                    ProfilePicView(user: participant!)
                }
            }
            else if otherParticipants != nil && otherParticipants!.count > 1 {
                GroupProfilePicView(users: otherParticipants!)
            }
            
            
            VStack(alignment: .leading, spacing: 4) {
                // 名前
                if let otherParticipants = otherParticipants {
                    Group {
                        if otherParticipants.count == 1 {
                            Text("\(participant!.firstname ?? "") \(participant!.lastname ?? "")")
                        }
                        else if otherParticipants.count == 2 {
                            
                            let participant2 = otherParticipants[1]
                            
                            Text("\(participant!.firstname ?? ""), \(participant2.firstname ?? "")")
                        }
                        else if otherParticipants.count > 2 {
                            
                            let participant2 = otherParticipants[1]
                            
                            Text("\(participant!.firstname ?? ""), \(participant2.firstname ?? "") + \(otherParticipants.count - 2) others")
                        }
                    }
                    .font(.button)
                    .foregroundColor(Color("text-primary"))
                }
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

