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
    @State private var messages: [Message] = [
        Message(id: "1", sender: "Juan Pérez", content: "¡Hola! ¿Cómo estás?", timestamp: "Hace 5 min"),
        Message(id: "2", sender: "Tú", content: "Estoy bien, ¿y tú?", timestamp: "Hace 4 min")
    ]
    
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
    }
    
    private func sendMessage() {
        guard !mensaje.isEmpty else { return }
        
        let newMessage = Message(id: "", sender: "Tú", content: mensaje, timestamp: "Justo ahora")
        messages.append(newMessage)
        mensaje = "" 
    }
}

#Preview {
    ContactsConversationView(nombre: "Angel Perez")
}
