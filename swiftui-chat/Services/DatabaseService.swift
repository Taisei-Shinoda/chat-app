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
                    
                    // TODO: 画像への完全なURLを取得する
                    /// ダウンロード URL を非同期に取得します。これは他の人とファイルを共有するために使用できますが、
                    /// 開発者がFirebase Consoleで取り消せます
                    fileRef.downloadURL { url, error in
                        if url != nil && error == nil {
                            doc.setData(["photo" : url!.absoluteString], merge: true) { error in
                                if error == nil {
                                    completion(true)
                                }
                            }
                        }
                        else {
                            // 画像のURLを取得できませんでした
                            completion(false)
                        }
                    }
                }
                else {
                    // アップロードできなかった場合
                    completion(false)
                }
            }
        }
//        else {
//            // 画像が選択されませんでした
//            completion(true)
//        }
        
        
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
    
 // MARK: - チャットメソッド
    /// ログインしたユーザーが参加している場合、このメソッドは全てのチャットを返します　
    func getAllChats(completion: @escaping ([Chat]) -> Void) {
        
        let db = Firestore.firestore()
        
        let chatsQuery = db.collection("chats").whereField("participantids", arrayContains: AuthViewModel.getLoggedInUserId())
        
        chatsQuery.getDocuments { snapshot, error in
            if snapshot != nil && error == nil {
                var chats = [Chat]()
                for doc in snapshot!.documents {
                    let chat = try? doc.data(as: Chat.self)
                        if let chat = chat {
                            chats.append(chat)
                    }
                }
                completion(chats)
            } else {
                print("データベースの検索でエラーが発生しました")
            }
        }
    }
    
    /// このメソッドは全てのチャットを戻します
    func getAllMessages(chat: Chat, completion: @escaping ([ChatMessage]) -> Void) {
        guard chat.id != nil else {
            completion([ChatMessage]())
            return
        }
        
        let db = Firestore.firestore()
        
        let msgsQuery = db.collection("chats").document(chat.id!).collection("msgs").order(by: "timestamp")
        
        msgsQuery.getDocuments { snapshot, error in
            if snapshot != nil && error == nil {
                var messages = [ChatMessage]()
                for doc in snapshot!.documents {
                    let msg = try? doc.data(as: ChatMessage.self)
                    if let msg = msg {
                        messages.append(msg)
                    }
                }
                completion(messages)
            } else {
                print("データベースの検索でエラーが発生しました")
            }
        }
    }
    
    
    /// このメソッドはデータベースへメッセージなどの情報を追加します
    func sendMessage(msg: String, chat: Chat) {
        guard chat.id != nil else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("chats").document(chat.id!).collection("msgs")
            .addDocument(data: ["imageurl": "",
                                "msg": msg,
                                "senderid": AuthViewModel.getLoggedInUserId(),
                                "timestamp": Date()])
    }
    
    
    func createChat(chat: Chat, completion: @escaping (String) -> Void) {
        let db = Firestore.firestore()
        
        let doc = db.collection("chats").document()
        
        try? doc.setData(from: chat, completion: { error in
            completion(doc.documentID)
        })
        
    }
    
}
