//
//  ForumView.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//

import SwiftUI

struct ForumView: View {
    @State private var posts: [Post] = [
        Post(id: "1", author: "Juan Pérez", message: "Hola a todos! 😊", timestamp: "Hace 5 min", replies: [], replyText: ""),
        Post(id: "2", author: "María López", message: "¿Alguien recomienda una buena app de productividad? 📱", timestamp: "Hace 10 min", replies: [], replyText: ""),
        Post(id: "3", author: "Carlos Díaz", message: "¡Qué buen foro! 🎉", timestamp: "Hace 20 min", replies: [], replyText: "")
    ]
    
    @State private var newPostText: String = ""

    var body: some View {
        NavigationView{
            NavigationStack {
                VStack {
                    List {
                        // Itera sobre el array de posts usando el índice
                        ForEach(posts.indices, id: \.self) { index in
                            PostView(post: $posts[index])
                        }
                    }
                    .listStyle(.plain)
                    
                    // Campo para agregar nuevo post
                    HStack {
                        TextField("Escribe algo...", text: $newPostText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, 10)

                        Button(action: addPost) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                    .background(Color.white)
                }
                .navigationTitle("Foro")
            }
        }
    }
    
    // Función para agregar un nuevo post
    private func addPost() {
        guard !newPostText.isEmpty else { return }
        let newPost = Post(id: "1", author: "Tú", message: newPostText, timestamp: "Justo ahora", replies: [], replyText: "")
        posts.insert(newPost, at: 0)
        newPostText = ""
    }
}

#Preview {
    ForumView()
}
