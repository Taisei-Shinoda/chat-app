//
//  ContanctRow.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/29.
//

import SwiftUI

struct ContanctRow: View {
    
    var user: User
    
    var body: some View {
        
        HStack(spacing: 24) {
            
            // プロファイル画像
            ZStack {
                if user.photo == nil {
                    ZStack {
                        Circle()
                            .foregroundColor(.white)
                        Text(user.firstname?.prefix(1) ?? "")
                            .bold()
                    }
                } else {
                    //TODO: ユーザーの画像からURLを作成します
                    let photoUrl = URL(string: user.photo ?? "")
                    
                    /// 画像を非同期にロードして表示するビューです。
                    AsyncImage(url: photoUrl) { phase in
                        
                        switch phase {
                            
                        case AsyncImagePhase.empty:
                            ProgressView()
                            
                        case AsyncImagePhase.success(let image):
                            image
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFill()
                                .clipped()
                            
                        case AsyncImagePhase.failure(let error):
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                Text(user.firstname?.prefix(1) ?? "")
                                    .bold()
                            }
                        }
                    }
                }
                Circle()
                    .stroke(Color("create-profile-border"), lineWidth: 2)
            }
            .frame(width: 44, height: 44)
            
            VStack(alignment: .leading, spacing: 4) {
                // 名前
                Text("\(user.firstname ?? "") \(user.lastname ?? "")")
                    .font(.button)
                    .foregroundColor(Color("text-primary"))
                
                // 電話番号
                Text(user.phone ?? "")
                    .font(.bodyParagraph)
                    .foregroundColor(Color("text-input"))
            }
            Spacer()
        }
    }
}
/*
 struct ContanctRow_Previews: PreviewProvider {
 static var previews: some View {
 ContanctRow()
 }
 }
 
 
 */
