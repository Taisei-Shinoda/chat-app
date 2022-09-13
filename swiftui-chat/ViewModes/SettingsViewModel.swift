//
//  SettingsViewModel.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/09/12.
//

import Foundation
import SwiftUI


class SettingsViewModel: ObservableObject {
    
    @AppStorage(Constans.DarkModeKey) var isDarkMode = false
    
    var databaseService = DatabaseService()
    
    func deactivateAccount(completion: @escaping () -> Void) {
        databaseService.deactivateAccount {
            completion()
        }
    }
}
