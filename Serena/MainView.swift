//
//  MainView.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: String = "Contacts"
    var user: User
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if selectedTab == "Contacts" {
                        ContactsView(user: user)
                    } else if selectedTab == "Forum" {
                        ForumView(user: user)
                    }
                    Spacer().padding(.bottom).frame(height: 100)
                }
                NavigationBarView(selectedTab: $selectedTab).padding(.bottom)
            }.ignoresSafeArea().background(Color.white)
        }
    }
}

#Preview {
    var ad = ReadJsonData()
    MainView(user: ad.appDatas.first?.users[1] ?? User(
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
