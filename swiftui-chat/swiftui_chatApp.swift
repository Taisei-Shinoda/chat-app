//
//  swiftui_chatApp.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/20.
//

import SwiftUI

@main
struct swiftui_chatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var contactsViewModel = ContactsViewModel()
    @StateObject var chatViewModel = ChatViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(contactsViewModel)
                .environmentObject(chatViewModel)
                .environmentObject(settingsViewModel)
                .preferredColorScheme(settingsViewModel.isDarkMode ? .dark : .light)
        }
    }
//    
//    init() {
//            FirebaseApp.configure()
//    }
}
