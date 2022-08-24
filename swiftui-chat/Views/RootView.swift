//
//  ContentView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/20.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .contacts
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .font(.chatHeading)
            
            Spacer()
            
            CustomTabBar(selectedTabs: $selectedTab)
        }
        
//         指定したブール値へのバインディングがtrueのとき、画面のできるだけ広い範囲をカバーするモーダルビューを提示する。 = 「閉じるまで他のことをさせねーぜ」的な意味
//
        .fullScreenCover(isPresented: $isOnboarding) {
            // on DISMISS
            
        } content: {
            OnboadingContainerView(isOnbording: $isOnboarding)
        }

    }
    
    /*
     -- フォント検索 --
     init() {
     for family in UIFont.familyNames {
     print(family)
     
     for fontname in UIFont.fontNames(forFamilyName: family) {
     print("--\(fontname)")
     }
     }
     */
}


struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
