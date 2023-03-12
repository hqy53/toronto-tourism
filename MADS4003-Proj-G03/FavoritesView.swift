//
//  FavoritesView.swift
//  MADS4003-Proj-G03
//
//  Created by anthony on 2023-03-02.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var currUser : User
    
    @State private var favoritesList = [Activity]()
    @State private var linkSelection : Int? = nil
    @State private var showRemoveAllButton = false
    
    var body: some View {
        NavigationView{
            
            ZStack(alignment: .bottom){
                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true).toolbar(.hidden, for: .tabBar), tag: 2, selection: self.$linkSelection){}
                
                if (self.favoritesList.isEmpty){
                    Text(NSLocalizedString("Empty", comment: "Empty library message"))
                }
                else{
                    List{
                        ForEach(self.favoritesList){ curr in
                            CustomListTileView2(activity: curr)
                        }
                        .onDelete(perform: { indexSet in
                            print(#function, "trying to delete list tile from idexSet : \(indexSet)")
                            print(self.favoritesList)
                            self.favoritesList.remove(atOffsets: indexSet)
                            print(#function, "favoritesList : \(self.favoritesList)")
                            print(self.favoritesList)
                            
                            if self.favoritesList.isEmpty{
                                self.showRemoveAllButton = false
                            }
                            
                            // update to UserDefaults
                            if let encodedData = try? JSONEncoder().encode(self.favoritesList){
                                UserDefaults.standard.set(encodedData, forKey: currUser.email)
                                print("\(indexSet) element removed")
                            }
                        })
                    }
                    
                }
            }
            .navigationBarTitle(Text(NSLocalizedString("Favorites", comment: "title of the app")))
            .navigationBarItems(
                leading: Group {
                    if showRemoveAllButton {
                        Button(action: {
                            favoritesList.removeAll()
                            UserDefaults.standard.removeObject(forKey: currUser.email)
                            self.showRemoveAllButton = false
                        }) {
                            Text("Remove All")
                                .foregroundColor(Color(UIColor(named: "TextTileColor") ?? UIColor(Color.red)))
                        }
                    }
                },
                trailing: Button(action: {
                    UserDefaults.standard.removeObject(forKey: "userEmail")
                    UserDefaults.standard.removeObject(forKey: "userPassword")
                    UserDefaults.standard.removeObject(forKey: "rememberMe")
                    print("Logout. UserDefaults info is deleted.")
                    self.linkSelection = 2
                }) {
                    Text("Logout")
                        .foregroundColor(Color(UIColor(named: "TextTileColor") ?? UIColor(Color.blue)))
                })

            
        }
        .onAppear(perform: {
            self.loadInitialData()
        })
        .onDisappear(perform: {
            favoritesList.removeAll()
        })
    }
    
    
    
    private func loadInitialData(){
        
        // read from UserDefaults
        if let data = UserDefaults.standard.data(forKey: currUser.email) {
            do {
                self.showRemoveAllButton = true
                favoritesList = try JSONDecoder().decode([Activity].self, from: data)
                
            } catch {
                print("Unable to Decode Array of Activity (\(error))")
            }
        }
        
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView().environmentObject(User())
    }
}

struct CustomListTileView2 : View{
    
    var activity: Activity
    
    var body : some View{
        
        
        HStack(alignment: .center){
            Image(activity.photo1)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:100, height: 100)
                .clipped()
            
            
            
            VStack(alignment: .leading){
                Text("\(activity.name)")
                    .font(.system(size: 19))
                    .bold()
                
                Text("Price: $\(String(format: "%.2f", activity.price)) / person")
                
                
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(Color(UIColor(named: "TextTileColor") ?? UIColor(Color.black)))
        
        
        
    }
}
