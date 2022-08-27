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
        /// true の場合、可能な限り画面全体をカバーするモーダル ビューを表示します。
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
