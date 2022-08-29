//
//  DatabaseService.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/25.
//

import Foundation
import Contacts
import Firebase
import UIKit
import FirebaseStorage


class DatabaseService {
    
    func getPlatformUsers(localContacts: [CNContact],
                          completion: @escaping ([User]) -> Void) {
        
        var platformUsers = [User]()
        
        var lookupPhoneNumbers = localContacts.map { contact in
            return TextHelper.sanitizePhoneNumber(contact.phoneNumbers.first?.value.stringValue ?? "")
        }
        
        guard lookupPhoneNumbers.count > 0 else {
            completion(platformUsers)
            return
        }
        
        let db = Firestore.firestore()
        
        while !lookupPhoneNumbers.isEmpty {
            
            let tenPhoneNumbers = Array(lookupPhoneNumbers.prefix(10))
            lookupPhoneNumbers = Array(lookupPhoneNumbers.dropFirst(10))
            
            let query = db.collection("users").whereField("phone", in: tenPhoneNumbers)
            query.getDocuments { snapshot, error in
                if error == nil && snapshot != nil {
                    for doc in snapshot!.documents {
                        if let user = try? doc.data(as: User.self) {
                            platformUsers.append(user)
                        }
                    }
                    
                    if lookupPhoneNumbers.isEmpty {
                        completion(platformUsers)
                    }
                }
            }
        }
        
    }
    
    func setUserProfile(firstName: String,
                        lastName: String,
                        image: UIImage?,
                        completion: @escaping(Bool) -> Void) {
        
        //TODO: ログアウトしたユーザーの再ログイン
        guard AuthViewModel.isUserLoggedIn() != false else {
            return
        }
        
        let userPhone = TextHelper.sanitizePhoneNumber(AuthViewModel.getLoggedInUserPhone())
        let db = Firestore.firestore()
        
        let doc = db.collection("users").document(AuthViewModel.getLoggedInUserId())
        doc.setData(["frstname": firstName,
                     "lasname": lastName,
                     "phone": userPhone])
        
        // 画像のチェック
        if let image = image {
            let storageRef = Storage.storage().reference()
            let imageData = image.jpegData(compressionQuality: 0.8)
            guard imageData != nil else {
                return
            }
            let path = "images/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            
            let uploadTask = fileRef.putData(imageData!, metadata: nil) { meta, error in
                if error == nil && meta != nil {
                    doc.setData(["photo" : path], merge: true) { error in
                        if error == nil {
                            completion(true)
                        }
                    }
                } else {
                    // アップロードできなかった場合
                    completion(false)
                }
            }
        }
        
        
    }
    
    
    func checkUserProfile(completion: @escaping (Bool) -> Void) {
        
        guard AuthViewModel.isUserLoggedIn() != false else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(AuthViewModel.getLoggedInUserId()).getDocument { snapShot, error in
            
            // TODO: ユーザーのプロファイルデータについて
            if snapShot != nil && error == nil {
                completion(snapShot!.exists)
            } else {
                // TODO: Result TYPE のアクセス失敗
                completion(false)
            }
        }
    }
    
    
}
