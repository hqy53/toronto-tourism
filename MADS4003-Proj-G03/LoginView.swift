//
//  LoginView.swift
//  MADS4003-Proj-G03
//
//  Created by Qianying Huang on 2023/3/5.
//

import SwiftUI

struct LoginView: View {
    
    //EnvironmentObject injects an instance of the User class, which is a model object that represents the user of the app
    @EnvironmentObject var currUser : User
    
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var errorMessage = ""
    @State private var linkSelection : Int? = nil
    
    let user1 = User(email: "user1@gmail.com", password: "password1")
    let user2 = User(email: "user2@gmail.com", password: "password2")
    
    // check if the user has entered a valid email and password
    func isValid() -> Bool {
        if email.isEmpty {
            errorMessage = "Please enter your email."
            return false
        } else if (password.isEmpty){
            errorMessage = "Please enter your password."
            return false
        } else {
            return true
        }
    }
    
    // handles the login button tap and validates the user's credentials
    func login() {
        if isValid() {
            // Check if email and password match a user
            if let matchedUser = [user1, user2].first(where: { $0.email == email && $0.password == password }) {
                print("User logged in: \(matchedUser.email) password: \(matchedUser.password)")
                errorMessage = ""
                
                // If the user checks rememberMe, save the data in UserDefaults
                if rememberMe {
                    UserDefaults.standard.set(email, forKey: "userEmail")
                    UserDefaults.standard.set(password, forKey: "userPassword")
                    UserDefaults.standard.set(rememberMe, forKey: "rememberMe")
                    print("Checked rememberMe. Saved in UserDefaults successfully.")
                }
                
                self.linkSelection = 1
                currUser.email = matchedUser.email
            } else {
                // If not, display an error message
                errorMessage = "Invalid email or password"
            }
        }
    }
    
    // Check if user details exist in UserDefaults and automatically log in the user
    func checkUserDefaults() {
        if UserDefaults.standard.bool(forKey: "rememberMe") {
            if let savedEmail = UserDefaults.standard.string(forKey: "userEmail"),
               let savedPassword = UserDefaults.standard.string(forKey: "userPassword") {
                self.email = savedEmail
                self.password = savedPassword
                self.rememberMe = true
                print("Auto log in as \(savedEmail)")
                self.linkSelection = 1
                
            }
        }
    }
    var body: some View {

        NavigationView{
            
            
            VStack {
                NavigationLink(destination: ContentView()
                    .navigationBarBackButtonHidden(true), tag: 1, selection: self.$linkSelection){}
                
                
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Toggle("Remember Me", isOn: $rememberMe)   //allows users to save their login credentials for future use
                    .padding()
                Button(action: {
                    login()
                }){
                    Text("Login")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                Text(errorMessage)
                    .foregroundColor(.red)
                
            }
            
            .padding([.leading, .bottom, .trailing])
            .onAppear {
                checkUserDefaults()
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
