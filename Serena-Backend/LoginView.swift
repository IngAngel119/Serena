//
//  LoginView.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//

import SwiftUI

struct LoginView: View {
    var ad = ReadJsonData()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = true
    @State private var isLoggedIn: Bool = false
    @State private var showAlert: Bool = false
    @State private var currentUser: User? = nil
    
    var body: some View {
        VStack{
            if isLoggedIn {
                MainView(user: currentUser ?? User(id: "1", name: "Error", email: "Admin@error.com", password: "error", avatar: "person.fill", isPsicologist: false))
            }
            else{
                NavigationView {
                    VStack {
                        // Header
                        VStack(alignment: .leading, spacing: 0) {
                            Color(hex: "#8FD5E5")
                                .ignoresSafeArea()
                            
                            HStack {
                                Text("HOLA")
                                    .font(.largeTitle).bold()
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                            }
                            
                            Text("¡Bienvenido!")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding(.top, -70)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 50)
                        .padding(.bottom, 100)
                        .background(Color(hex: "#8FD5E5"))
                        .frame(height: 260)
                        
                        Spacer()
                        
                        // Formulario de login
                        VStack(spacing: 20) {
                            CustomTextField(placeholder: "Gmail", text: $email, isSecure: false)
                            CustomTextField(placeholder: "Contraseña", text: $password, isSecure: true)
                            
                            Button(action: login) {
                                Text("INGRESAR")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(hex: "#8fd5e5"))
                                    .cornerRadius(25)
                            }
                            
                            Text("¿No tienes una cuenta? ")
                                .foregroundColor(.gray) +
                            Text("Crea una")
                                .foregroundColor(Color(hex: "#8fd5e5"))
                                .bold()
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 50)
                        
                        Spacer()
                        
                        Text("© Serena 2025")
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                    .background(Color.white)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("¡Bienvenido!"),
                            message: Text("Has iniciado sesión correctamente."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
        }
        
    }
    
    func login() {
        // Busca el usuario con las credenciales ingresadas
        if let user = ad.self.users.first(where: { $0.email == email && $0.password == password }) {
            // Si se encuentra el usuario, pasa a la vista principal
            isLoggedIn = true
            currentUser = user  // Guarda el usuario logueado
            showAlert = true
        } else {
            // Si no hay coincidencias, muestra una alerta
            showAlert = true
        }
    }

}

// Custom TextField
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    LoginView()
}
