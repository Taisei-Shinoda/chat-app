//
//  ContactsViewModel.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/25.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject {
    
    @Published var users = [User]()
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
                    }
                }
                
            } catch {
                
            }
        }
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
