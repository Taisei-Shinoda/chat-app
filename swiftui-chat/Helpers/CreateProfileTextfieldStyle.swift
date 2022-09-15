//
//  CreateProfileTextfieldStyle.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/24.
//

import Foundation
import SwiftUI

struct CreateProfileTextfieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("input"))
                .cornerRadius(8)
                .frame(height: 46)
            
            configuration
                .foregroundColor(Color("text-textfield"))
                .font(.tabBar)
                .padding()
        }
    }
}
