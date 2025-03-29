//
//  ForumView.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//

import SwiftUI

struct ForumView: View {
    @StateObject private var ad = ReadJsonData()
    @State private var posts: [Post] = []
    @State private var newPostText: String = ""
    var user: User

    var body: some View {
        NavigationView{
            NavigationStack {
                VStack {
                    List {
                        // Itera sobre el array de posts usando el índice
                        ForEach(posts.indices, id: \.self) { index in
                            PostView(post: $posts[index], ad: ad, user: user)
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
                .onAppear {
                    if let firstData = ad.appDatas.first {
                        posts = firstData.posts
                    }
                }
            }
        }
    }
    
    // Función para agregar un nuevo post
    private func addPost() {
        guard !newPostText.isEmpty else { return }
        let newPost = Post(id: UUID().uuidString, author: user.email, message: newPostText, timestamp: "Justo ahora", replies: [], replyText: "")
        
        // Agrega el nuevo post al array
        posts.insert(newPost, at: 0)
        newPostText = ""
        
        // Guarda los datos actualizados en el archivo JSON
        if var appData = ad.appDatas.first {
            appData.posts.append(newPost)
            ad.appDatas[0] = appData
            ad.saveData() // Guardar en JSON después de agregar el post
        }
    }
}

#Preview {
    var ad = ReadJsonData()
    ForumView(user: ad.appDatas.first?.users[0] ?? User(
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
