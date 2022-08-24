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
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
//    
//    init() {
//            FirebaseApp.configure()
//    }
}
