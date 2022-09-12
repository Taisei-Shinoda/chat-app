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
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @State var selectedTab: Tabs = .contacts
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    
    @State var isChatShowing = false
    
    @State var isSettingsShowing = false
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                
                switch selectedTab {
                case .chats:
                    ChatsListView(isChatShowing: $isChatShowing, isSettingsShowing: $isSettingsShowing)
                case .contacts:
                    ContactsListView(isChatShowing: $isChatShowing, isSettingsShowing: $isSettingsShowing)
                }
                
                Spacer()
                
                CustomTabBar(selectedTabs: $selectedTab, isChatShowing: $isChatShowing)
            }
        }
        .onAppear(perform: {
            if !isOnboarding {
                contactsViewModel.getLocalContacts()
            }
        })
        /// true の場合、可能な限り画面全体をカバーするモーダル ビューを表示します。
        .fullScreenCover(isPresented: $isOnboarding) {
            // on DISMISS
            
        } content: {
            OnboadingContainerView(isOnbording: $isOnboarding)
        }
        .fullScreenCover(isPresented: $isChatShowing, onDismiss: nil) {
            ConversationView(isChatShowing: $isChatShowing)
        }
        .fullScreenCover(isPresented: $isSettingsShowing, onDismiss: nil) {
            SettingsView(isSettingsShowing: $isSettingsShowing, isOnboarding: $isOnboarding)
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
