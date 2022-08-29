//
//  ContactsListView.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/29.
//

import SwiftUI

struct ContactsListView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @State var filterText = ""
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Contacts")
                    .font(.pageTitle)
                Spacer()
                Button {
                    //TODO: 設定
                    
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icons-secondary"))
                }
            }
            .padding(.top, 20)
            
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(20)
                
                TextField("Search contact or number", text: $filterText)
                    .font(.tabBar)
                    .foregroundColor(Color("text-textfield"))
                    .padding()
            }
            .frame(height: 46)
            .onChange(of: filterText) { _ in
                contactsViewModel.filterContacts(filterBy: filterText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
            }
            
            if contactsViewModel.filterdUsers.count > 0 {
                List(contactsViewModel.filterdUsers) { user in
                    
                    //TODO: 行
                    ContanctRow(user: user)
                        .listRowBackground(Color(.clear))
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .padding(.top, 12)
                
            } else {
                Spacer()
                
                Image("no-contacts-yet")
                Text("No chats yet")
                    .font(.titleText)
                    .padding(.top, 32)
                
                Text("Add some contacts to get started")
                    .font(.bodyParagraph)
                    .padding(.top, 8)
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .onAppear {
            contactsViewModel.getLocalContacts()
        }
    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView()
    }
}