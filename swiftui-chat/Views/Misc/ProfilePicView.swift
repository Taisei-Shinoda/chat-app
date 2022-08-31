//
//  ProfilePicView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/31.
//

import SwiftUI

struct ProfilePicView: View {
    
    var user: User
    
    var body: some View {
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
    }
}

struct ProfilePicView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicView(user: User())
    }
}
