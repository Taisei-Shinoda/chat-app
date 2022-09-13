//
//  ConversationPhotoMessage.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/09/10.
//

import SwiftUI

struct ConversationPhotoMessage: View {
    
    var imageUrl: String
    var isFromUser: Bool
    var isActive: Bool = true
    
    var body: some View {
        
        // ユーザーが非アクティブな状態です
        if !isActive {
            ConversationTextMessage(msg: "Photo deleted",
                                    isFromUser: isFromUser,
                                    name: nil,
                                    isActive: isActive)
        }
        // ユーザーがアクティブな状態です
        else if let cachedImage = CacheService.getImage(forkey: imageUrl) {
            cachedImage
                .resizable()
                .scaledToFill()
                .padding(.vertical, 16)
                .padding(.horizontal, 24)
                .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
        }
        else {
            // 画像のメッセージ
            let photoUrl = URL(string: imageUrl)
            
            /// 画像を非同期にロードして表示するビューです。
            AsyncImage(url: photoUrl) { phase in
                
                switch phase {
                    
                case AsyncImagePhase.empty:
                    ProgressView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .padding(.vertical, 16)
                        .padding(.horizontal, 24)
                        .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                        .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                        .onAppear {
                            CacheService.setImage(image: image, forkey: imageUrl)
                        }
                    
                    
                case .failure:
                    ConversationTextMessage(msg: "画像をロードできませんでした", isFromUser: isFromUser)
                }
            }
        }
    }
}

struct ConversationPhotoMessage_Previews: PreviewProvider {
    static var previews: some View {
        ConversationPhotoMessage(imageUrl: "", isFromUser: true)
    }
}
