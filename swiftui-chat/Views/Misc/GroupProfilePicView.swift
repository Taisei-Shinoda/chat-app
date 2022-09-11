//
//  GroupProfilePicView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/09/11.
//

import SwiftUI

struct GroupProfilePicView: View {
    
    var users: [User]
    
    var body: some View {
        let offset = Int(30 / users.count) * -1
        
        ZStack {
            ForEach(Array(users.enumerated()), id: \.element) { index, user in
                ProfilePicView(user: user)
                    .offset(x: CGFloat(offset * index))
            }
        }
        .offset(x: CGFloat((users.count - 1) * abs(offset) / 2))
    }
}
