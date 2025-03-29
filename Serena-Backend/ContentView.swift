//
//  ContentView.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showLoginView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
          
                Color(hex: "#8FD5E5")
                    .ignoresSafeArea()
                
              
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
               
                NavigationLink(
                    destination: LoginView(),
                    isActive: $showLoginView,
                    label: {
                        EmptyView()
                    })
            }
            .onAppear {
               
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.showLoginView = true
                }
            }
        }
    }
}

// Colores hexadecimales
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let red = Double((color & 0xFF0000) >> 16) / 255.0
        let green = Double((color & 0x00FF00) >> 8) / 255.0
        let blue = Double(color & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

#Preview {
    ContentView()
}

