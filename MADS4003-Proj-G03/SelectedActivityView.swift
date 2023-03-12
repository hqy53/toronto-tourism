//
//  SelectedActivityView.swift
//  MADS4003-Proj-G03
//
//  Created by anthony on 2023-03-02.
//

import SwiftUI

struct SelectedActivityView: View {
    
    @EnvironmentObject var currUser:User
    @State private var linkSelection : Int? = nil
    @State private var favoritesList = [Activity]()
    @State private var alreadyExist = false
    
    let selectedActivity : Activity
    
    var body: some View {
        
        
        VStack(){

            NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true).toolbar(.hidden, for: .tabBar), tag: 2, selection: self.$linkSelection){}
            
            VStack{
                Text("\(selectedActivity.name)")
                    .font(.system(size: 27))
                    .bold()
                    .padding(.horizontal)
                
                
                Spacer()
                
                Text("Price: $\(String(format: "%.2f", selectedActivity.price)) / person")
                    .padding(.horizontal)
                
                Spacer()
                
                HStack(alignment: .center){
                    Image(selectedActivity.photo1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.horizontal)
                        .frame(width:175, height: 175)
                        .clipped()
                    
                    Image(selectedActivity.photo2)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.horizontal)
                        .frame(width:175, height: 175)
                        .clipped()
                    
                }
                
                Spacer()
                
                Text("\(selectedActivity.description)")
                    .padding(.horizontal)
                
                Spacer()
                
               // Text("Rating: \(selectedActivity.rating) / 5")
                HStack{
                    
                    HStack {
                        ForEach(0..<selectedActivity.rating) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                                .frame(minWidth: 35, minHeight: 35)
                        }
                        ForEach(0..<(5 - selectedActivity.rating)) { _ in
                            Image(systemName: "star")
                                .foregroundColor(Color.yellow)
                                .frame(minWidth: 35, minHeight: 35)
                        }
                    }
                    
                  
                }
                
                Spacer()
            }
            
            
            Button(action: {
                let phoneNumber = selectedActivity.host
                let numberUrl = URL(string: "tel://\(phoneNumber)")!
                if UIApplication.shared.canOpenURL(numberUrl) {
                    UIApplication.shared.open(numberUrl)
                }
            }){
                Text("Contact: \(selectedActivity.host)")
                    .padding(.bottom)
            }
            
            
            HStack(spacing: 80.0){
                ShareLink(item: "\(selectedActivity.name), $\(String(format: "%.2f", selectedActivity.price)) / person, Contact: \(selectedActivity.host)")
                    .fontWeight(.regular)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                
                
                
                Button(action: {
                    
                    // read favoritesList from UserDefaults
                    if let data = UserDefaults.standard.data(forKey: currUser.email) {
                        do {
                            // Create JSON Decoder
                            let decoder = JSONDecoder()
                            
                            // Decode Note
                            favoritesList = try decoder.decode([Activity].self, from: data)
                        } catch {
                            print("Unable to Decode Array of Activity (\(error))")
                        }
                    }
                    
                    // check duplicate
                    for item in favoritesList{
                        if item.name == selectedActivity.name{
                            alreadyExist = true
                        }
                    }
                    if !alreadyExist{
                        favoritesList.append(selectedActivity)
                        // save to userdefaults
                        if let encodedData = try? JSONEncoder().encode(favoritesList){
                            UserDefaults.standard.set(encodedData, forKey: currUser.email)
                        }
                    }
                    
                    
                }){
                    Text("Favorite")
                        .fontWeight(.regular)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)

                    
                }
                .alert("Already exists!", isPresented: $alreadyExist)
                {
                    Button("OK", role: .cancel){}
                }
                
                
            }
            .padding(.bottom)

            
        }
        .navigationBarItems(trailing: Button(action: {
            UserDefaults.standard.removeObject(forKey: "userEmail")
            UserDefaults.standard.removeObject(forKey: "userPassword")
            UserDefaults.standard.removeObject(forKey: "rememberMe")
            print("Logout. UserDefaults info is deleted.")
            self.linkSelection = 2
        }) {
            Text("Logout")
                .foregroundColor(Color(UIColor(named: "TextTileColor") ?? UIColor(Color.blue)))
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }//body ends
    
}


