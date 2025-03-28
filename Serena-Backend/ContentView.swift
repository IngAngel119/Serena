//
//  ContentView.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: String = "Contacts"
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if selectedTab == "Contacts" {
                        ContactsView()
                    } else if selectedTab == "Forum" {
                        ForumView()
                    }
                    Spacer().padding(.bottom).frame(height: 100)
                }
                NavigationBarView(selectedTab: $selectedTab).padding(.bottom)
            }.ignoresSafeArea().background(selectedTab == "Forum" ? Color.white : Color.gray.opacity(0.1))
        }
    }
}

#Preview {
    ContentView()
}

