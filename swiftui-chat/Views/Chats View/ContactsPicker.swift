//
//  ContactsPicker.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/09/10.
//

import SwiftUI

struct ContactsPicker: View {
    
    @Binding var isContactsPickerShowing: Bool
    @Binding var selectedContacts: [User]
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    var body: some View {
        ZStack {
            
            Color("background")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                ScrollView {
                    ForEach(contactsViewModel.filterdUsers) { user in
                        
                        if user.isactive {
                            let isSelectedContact = selectedContacts.contains { u in
                                u.id == user.id
                            }
                            
                            ZStack {
                                ContanctRow(user: user)
                                
                                HStack {
                                    Spacer()
                                    
                                    Button {
                                        if isSelectedContact {
                                           let index = selectedContacts.firstIndex(of: user)
                                            if let index = index {
                                                selectedContacts.remove(at: index)
                                            }
                                        }
                                        else {
                                            if selectedContacts.count < 3 {
                                            selectedContacts.append(user)
                                        }
                                            else {
                                            }
                                        }
                                        
                                    } label: {
                                        Image(systemName: isSelectedContact ? "checkmark.circle.fill" : "checkmark.circle")
                                            .resizable()
                                            .foregroundColor(Color("button-primary"))
                                            .frame(width: 25, height: 25)
                                    }
                                    
                                }
                            }
                            .padding(.top, 18)
                            .padding(.horizontal)
                        }
                    }
                }
                
                Button {
                    isContactsPickerShowing = false
                } label: {
                    
                    ZStack {
                        Color("button-primary")
                        
                        Text("Done")
                            .font(.button)
                            .foregroundColor(Color("text-button"))
                    }
                }
                .frame(height: 56)
            }
        }
        .onAppear {
            contactsViewModel.filterContacts(filterBy: "")
        }
    }
}

