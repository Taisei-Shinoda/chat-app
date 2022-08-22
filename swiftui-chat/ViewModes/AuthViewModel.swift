//
//  AuthViewModel.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/22.
//

import Foundation
import Firebase


class AuthViewModel {
    
    static func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    static func getLoggedInUserId() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    static func logout() {
        try? Auth.auth().signOut()
    }
}
