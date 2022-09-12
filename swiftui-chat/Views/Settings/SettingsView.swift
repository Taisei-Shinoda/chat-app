//
//  SettingsView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/09/12.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isSettingsShowing: Bool
    @Binding var isOnboarding: Bool
    
    @State var isDarkMode = false
    
    var body: some View {
        
        ZStack {
            
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Text("Settings")
                        .font(.pageTitle)
                    
                    Spacer()
                    
                    Button {
                        // Close
                        isSettingsShowing = false
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .tint(Color("icons-secondary"))
                    }
                    
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                Form {
                    
                    Toggle("Dark Mode", isOn: $isDarkMode)
                    
                    
                    Button {
                       // TODO: "LOG OUT" BUTTON
                        AuthViewModel.logout()
                        isOnboarding = true
                    } label: {
                        Text("LOG OUT")
                    }
                    
                    
                    Button {
                       // TODO: "DELETE ACOUNT" BUTTON
                    } label: {
                        Text("DELETE ACOUNT")
                    }
                }
            }
        }
    }
}
