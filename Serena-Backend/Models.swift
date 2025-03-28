//
//  Models.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//
import SwiftUI

import Foundation

struct Chat: Identifiable, Codable {
    let id: String
    let name: String
    let lastMessage: String
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
}


struct IconBar: View {
    let icon: String
    let text: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(.black)
            Text(text)
                .font(.footnote)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
    }
}

struct PostView: View {
    @Binding var post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(post.author)
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
                        Text(reply.author)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        Text(reply.message)
                            .font(.body)
                            .padding(.leading, 20)
                    }
                }
            }

            // Responder al post
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
                        .background(Color.green)
                        .clipShape(Circle())
                }
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    private func addReply() {
        guard !post.replyText.isEmpty else { return }
        // Agregar respuesta al post
        var updatedPost = post
        let newReply = Reply(id: "", author: "Tú", message: post.replyText, timestamp: "Justo ahora")
        updatedPost.addReply(reply: newReply)
        post = updatedPost
        post.replyText = "" // Limpiar el campo de respuesta
    }
}
