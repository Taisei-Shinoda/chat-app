//
//  ContentView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/20.
//

import SwiftUI

struct RootView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @State var selectedTab: Tabs = .contacts
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    
    @State var isChatShowing = false
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                
                switch selectedTab {
                case .chats:
                    ChatsListView(isChatShowing: $isChatShowing)
                case .contacts:
                    ContactsListView(isChatShowing: $isChatShowing)
                }
                
                Spacer()
                
                CustomTabBar(selectedTabs: $selectedTab)
            }
        }
        /// true の場合、可能な限り画面全体をカバーするモーダル ビューを表示します。
        .fullScreenCover(isPresented: $isOnboarding) {
            // on DISMISS
            
        } content: {
            OnboadingContainerView(isOnbording: $isOnboarding)
        }
        .fullScreenCover(isPresented: $isChatShowing, onDismiss: nil) {
            ConversationView(isChatShowing: $isChatShowing)
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                print("アクティブ")
            } else if newPhase == .inactive {
                print("イナクティブ")
            } else if newPhase == .background {
                print("バックグラウンド")
                chatViewModel.chatListViewCleanup()
            }
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
