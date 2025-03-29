//
//  ContactsView.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//

import SwiftUI

struct ContactsView: View {
    var ad = ReadJsonData()
    var user: User
    
    var body: some View {
        NavigationView {
            List(user.chats) { chat in
                NavigationLink(destination: ContactsConversationView(nombre: chat.name, ad: ad, user: user)) {
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
    var ad = ReadJsonData()
    ContactsView(user: ad.appDatas.first?.users[0] ?? User(
        id: "1",
        name: "Angel Escalante",
        email: "angel@gmail.com",
        password: "123456",
        avatar: "person.fill",
        isPsicologist: true,
        chats: [
            Chat(id: "1", name: "Juan Pérez", lastMessage: "Nos vemos mañana!", avatar: "person.fill"),
            Chat(id: "2", name: "María López", lastMessage: "Gracias por todo!", avatar: "person.fill")
        ]
    ))
}
