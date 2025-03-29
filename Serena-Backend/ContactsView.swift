//
//  ContactsView.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//

import SwiftUI

struct ContactsView: View {
    var ad = ReadJsonData()
    
    var body: some View {
        NavigationView {
            List(ad.appDatas.first?.chats ?? []) { chat in
                NavigationLink(destination: ContactsConversationView(nombre: chat.name, ad: ad)) {
                    contactSection(for: chat)
                }
            }
            .navigationTitle("Chats")
        }
    }
}

extension ContactsView {
    private func contactSection(for chat: Chat) -> some View {
        HStack {
            Image(systemName: chat.avatar)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .foregroundColor(Color(hex: "#8FD5E5"))
            
            Spacer().frame(width: 30)
            
            VStack(alignment: .leading) {
                Text(chat.name)
                    .font(.headline)
                Text(chat.lastMessage)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    ContactsView()
}
