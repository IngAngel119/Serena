//
//  ContactsView.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//

import SwiftUI

let chats = [
    Chat(id: "1", name: "Juan Pérez", lastMessage: "Nos vemos mañana!", avatar: "person.fill"),
    Chat(id: "2", name: "María López", lastMessage: "Gracias por todo!", avatar: "person.fill"),
    Chat(id: "3", name: "Carlos Díaz", lastMessage: "¡Hablemos luego!", avatar: "person.fill")
]

struct ContactsView: View {
    var body: some View {
        NavigationView {
            List(chats) { chat in
                NavigationLink(destination: ContactsConversationView(nombre: chat.name)) {
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
