//
//  Users.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/25.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var firstname: String?
    
    var lastname: String?
    
    var phone: String?
    
    var photo: String?
    
}

