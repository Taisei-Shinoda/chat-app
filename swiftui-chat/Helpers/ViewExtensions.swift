//
//  ViewExtensions.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/09/15.
//

import Foundation
import SwiftUI


extension View {
    func placeholder<Content: View>(when shouldShow: Bool,
                                    alignment: Alignment = .leading,
                                    @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

/// <Content: View> ⇦ この部分はViewタイプを受け入れる、という著名です

/// @ViewBuilder placeholder: () -> Content) ⇦ この部分は”この”メソッドが呼ばれたら、そのビュー(Content)に修飾子としての効果をかける、という意味です

