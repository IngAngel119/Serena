//
//  NavigationBarView.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//

import SwiftUI

struct NavigationBarView: View {
    @Binding var selectedTab: String
    
    var body: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 60)
                .shadow(radius: 2)
                .overlay(
                    HStack {
                        Spacer()
                        Button(action: { selectedTab = "Contacts" }) {
                            VStack {
                                Image(systemName: "person.fill")
                                Text("Contactos")
                                    .font(.caption)
                            }
                            .foregroundColor(selectedTab == "Contacts" ? Color(hex: "#8FD5E5") : .gray)
                        }
                        Spacer()
                        Button(action: { selectedTab = "Forum" }) {
                            VStack {
                                Image(systemName: "message")
                                Text("Foro")
                                    .font(.caption)
                            }
                            .foregroundColor(selectedTab == "Forum" ? Color(hex: "#8FD5E5") : .gray)
                        }
                        Spacer()
                    }
                )
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    @Previewable @State var selectedTab: String = "Contacts"
    NavigationBarView(selectedTab: $selectedTab)
}
