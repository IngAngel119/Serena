//
//  Models.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//
import SwiftUI

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let password: String
    let avatar: String
    let isPsicologist: Bool
    var chats: [Chat]
}

struct Chat: Identifiable, Codable {
    let id: String
    let name: String
    var lastMessage: String
    let avatar: String
}

struct Post: Identifiable, Codable {
    let id: String
    let author: String
    let message: String
    let timestamp: String
    var replies: [Reply]
    var replyText: String
    
    mutating func addReply(reply: Reply) {
        replies.append(reply)
    }
}

struct Reply: Identifiable, Codable {
    let id: String
    let author: String
    let message: String
    let timestamp: String
}

struct Message: Identifiable, Codable {
    let id: String
    let sender: String
    let destinatary: String
    let content: String
    let timestamp: String
}

struct AppData: Codable {
    var chats: [Chat]
    var posts: [Post]
    var messages: [Message]
    var users: [User]
}


struct IconBar: View {
    let icon: String
    let text: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(Color(hex: "#8FD5E5"))
            Text(text)
                .font(.footnote)
                .foregroundColor(Color(hex: "#8FD5E5"))
        }
        .frame(maxWidth: .infinity)
    }
}

struct PostView: View {
    @Binding var post: Post
    @ObservedObject var ad: ReadJsonData
    var user: User

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Anonimo")
                    .font(.headline)
                Text(post.timestamp)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Text(post.message)
                .font(.body)
                .padding(.top, 5)
            
            // Mostrar respuestas si hay
            if !post.replies.isEmpty {
                ForEach(post.replies) { reply in
                    VStack(alignment: .leading) {
                        Text("Respuesta")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        Text(reply.message)
                            .font(.body)
                            .padding(.leading, 20)
                    }
                }
            }
            
            // Responder al post solo si el usuario es psicólogo
            if user.isPsicologist {
                HStack {
                    TextField("Escribe una respuesta...", text: $post.replyText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)

                    Button(action: {
                        addReply()
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hex: "#8FD5E5"))
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 5)
            } else {
                // Aquí agregamos un HStack vacío para mantener la estructura del layout
                HStack {
                    Spacer()  // Mantener espacio vacío
                }
                .frame(height: 10)  // Ajusta la altura según el tamaño deseado
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    private func addReply() {
        guard !post.replyText.isEmpty else { return }
        
        // Crear la nueva respuesta
        let newReply = Reply(id: UUID().uuidString, author: user.name, message: post.replyText, timestamp: "Justo ahora")
        
        
        // Agregar la respuesta al post
        var updatedPost = post
        updatedPost.addReply(reply: newReply)
        post = updatedPost
        post.replyText = "" // Limpiar el campo de respuesta
        
        if let appData = ad.appDatas.first {
            if let userIndex = appData.users.firstIndex(where: { $0.email == post.author }) {
                // Obtener los chats actuales del usuario
                let userChats = ad.appDatas[0].users[userIndex].chats
                
                // Verificar si ya existe un chat con ese nombre
                if !userChats.contains(where: { $0.name == user.name }) {
                    // Si no existe, agregar el chat
                    ad.appDatas[0].users[userIndex].chats.append(
                        Chat(id: UUID().uuidString, name: user.name, lastMessage: "", avatar: "person.fill")
                    )
                    ad.saveData() // Guardar los cambios
                }
            }
        }

        
        // Guardar los cambios en el archivo JSON
        if let appData = ad.appDatas.first {
            // Buscar el índice del post en la lista
            if let postIndex = appData.posts.firstIndex(where: { $0.id == post.id }) {
                // Actualizar el post en la lista de datos
                ad.appDatas[0].posts[postIndex] = post
                ad.saveData() // Guardar los cambios
            }
        }
    }
}

