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
            ProfilePicView(user: user)
            
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
