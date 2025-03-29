//
//  ContactsConversationView.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//

import SwiftUI

struct ContactsConversationView: View {
    let nombre: String
    @State private var mensaje = ""
    @State private var messages: [Message] = []
    @ObservedObject var ad: ReadJsonData
    var user: User

    var body: some View {
        VStack {
            ScrollView {
                ForEach(messages) { message in
                    VStack(alignment: message.sender == user.name ? .trailing : .leading) {
                        Text(message.sender)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.horizontal)

                        Text(message.content)
                            .padding()
                            .background(message.sender == user.name ? Color.blue : Color.gray.opacity(0.2))
                            .cornerRadius(12)
                            .foregroundColor(message.sender == user.name ? .white : .black)
                            .frame(maxWidth: 300, alignment: message.sender == user.name ? .trailing : .leading)
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)
                }
            }

            HStack {
                TextField("Escribe un mensaje...", text: $mensaje)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 10)
                    .frame(height: 40)

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 10)
            }
            .padding()
        }
        .navigationTitle(nombre)
        .onAppear {
            loadMessages()
        }
    }

    private func loadMessages() {
        messages = ad.appDatas.first?.messages.filter {
            ($0.sender == nombre && $0.destinatary == user.name) ||
            ($0.sender == user.name && $0.destinatary == nombre)
        } ?? []
    }

    private func sendMessage() {
        guard !mensaje.isEmpty else { return }

        let newMessage = Message(id: UUID().uuidString, sender: user.name, destinatary: nombre, content: mensaje, timestamp: "Justo ahora")
        messages.append(newMessage)
        
        if let appData = ad.appDatas.first {
            if let userIndex = appData.users.firstIndex(where: { $0.name == newMessage.destinatary }) {
                // Verificar si ya existe un chat con ese nombre
                let userChats = ad.appDatas[0].users[userIndex].chats
                if !userChats.contains(where: { $0.name == newMessage.sender }) {
                    // Si no existe, agregar el chat
                    ad.appDatas[0].users[userIndex].chats.append(
                        Chat(id: UUID().uuidString, name: newMessage.sender, lastMessage: newMessage.content, avatar: "person.fill")
                    )
                    ad.saveData() // Guardar los cambios
                }
            }
        }

        if var appData = ad.appDatas.first {
            appData.messages.append(newMessage)
            ad.appDatas[0] = appData
            ad.saveData() // Guarda los datos en JSON
        }

        mensaje = ""
    }
}

#Preview {
    ContactsConversationView(nombre: "Juan Pérez", ad: ReadJsonData(), user: User(
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
