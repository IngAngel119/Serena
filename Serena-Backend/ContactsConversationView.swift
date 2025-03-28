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
    @StateObject private var ad = ReadJsonData()

    var body: some View {
        VStack {
            ScrollView {
                ForEach(messages) { message in
                    VStack(alignment: message.sender == "Tú" ? .trailing : .leading) {
                        Text(message.sender)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.horizontal)

                        Text(message.content)
                            .padding()
                            .background(message.sender == "Tú" ? Color.blue : Color.gray.opacity(0.2))
                            .cornerRadius(12)
                            .foregroundColor(message.sender == "Tú" ? .white : .black)
                            .frame(maxWidth: 300, alignment: message.sender == "Tú" ? .trailing : .leading)
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
            // Filtra los mensajes solo del contacto seleccionado
            messages = ad.appDatas.first?.messages.filter { ($0.sender == nombre && $0.destinatary == "Tú") || ($0.sender == "Tú" && $0.destinatary == nombre) } ?? []
        }
    }

    private func sendMessage() {
        guard !mensaje.isEmpty else { return }

        let newMessage = Message(id: UUID().uuidString, sender: "Tú", destinatary: nombre, content: mensaje, timestamp: "Justo ahora")
        messages.append(newMessage)
        mensaje = ""
    }
}

#Preview {
    ContactsConversationView(nombre: "Juan Pérez")
}
