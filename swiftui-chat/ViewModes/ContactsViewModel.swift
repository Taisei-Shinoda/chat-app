//
//  ContactsViewModel.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/25.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject {
    
    private var users = [User]()
    
    private var filterText = ""
    @Published var filterdUsers = [User]()
    
    private var localCotacts = [CNContact]()
    
    func getLocalContacts() {
        
        DispatchQueue.init(label: "getcontacts").async {
            do {
                let store = CNContactStore()
                
                let keys = [CNContactPhoneNumbersKey, CNContactGivenNameKey, CNContactFamilyNameKey] as! [CNKeyDescriptor]
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
                try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, succes in
                    self.localCotacts.append(contact)
                })
                
                // TODO: 連絡先で紐付いている友達をアプリで使用できるようにします
                DatabaseService().getPlatformUsers(localContacts: self.localCotacts) { platformUsers in
                    DispatchQueue.main.async {
                        self.users = platformUsers
                        
                        //TODO: フィルターリスト
                        self.filterContacts(filterBy: self.filterText)
                    }
                }
                
            } catch {
                
            }
        }
    }
    
    func filterContacts(filterBy: String) {
        
        // パラメータが存在する場合
        self.filterText = filterBy
        
        // テキストが空の場合
        if filterText == "" {
            self.filterdUsers = users
            return
        }
        
        // フィルターをかけます
        self.filterdUsers = users.filter({ user in
            user.firstname?.lowercased().contains(filterText) ?? false ||
            user.lastname?.lowercased().contains(filterText) ?? false ||
            user.phone?.lowercased().contains(filterText) ?? false
        })
    }
    
    /// ユーザーIDのリストを指定すると、ユーザーオブジェクトの同じIDを持つリストを返す。
    func getParticipants(ids: [String]) -> [User] {
        let foundUsers = users.filter { user in
            if user.id == nil {
                return false
            } else {
                return ids.contains(user.id!)
            }
        }
        return foundUsers
    }
    
    
}

/*
 let store = CNContactStore()
 do {
 let predicate = CNContact.predicateForContacts(matchingName: "Appleseed")
 let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
 print("Fetched contacts: \(contacts)")
 } catch {
 print("Failed to fetch contact, error: \(error)")
 // Handle the error
 }
 */
