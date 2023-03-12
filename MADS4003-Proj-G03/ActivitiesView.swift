//
//  ActivitiesView.swift
//  MADS4003-Proj-G03
//
//  Created by anthony on 2023-03-02.
//

import SwiftUI

struct ActivitiesView: View {
    
    @State private var activitiesList = [Activity]()
    @State private var linkSelection : Int? = nil
    
    var body: some View {
        
        NavigationView{
            
            ZStack(alignment: .bottom){
                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true).toolbar(.hidden, for: .tabBar), tag: 2, selection: self.$linkSelection){}
                
                if (self.activitiesList.isEmpty){
                    Text(NSLocalizedString("There is no activity in Toronto.", comment: "Empty library message"))
                }
                else{
                    List{
                        ForEach(self.activitiesList){ curr in
                            NavigationLink(destination: SelectedActivityView(selectedActivity: curr)){
                                CustomListTileView(activity: curr)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text(NSLocalizedString("Activities in Toronto", comment: "title of the app")))
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
        }
        .onAppear(perform: {
            self.loadInitialData()
        })
        .onDisappear(perform: {
            activitiesList.removeAll()
        })
        
    }
    
    
    private func loadInitialData(){
        var activityObj = Activity(name: "CN Tower EdgeWalk", desciption: "Toronto's famous landmark, the 553-meter CN Tower, is one of Ontario's must-see attractions and also the most impossible to miss. Towering above the downtown, this Canadian icon can be seen from almost everywhere in the city.", price: 19.99, rating: 3, host: "647-328-9843", photo1: "cntower1", photo2: "cntower2")
        self.activitiesList.append(activityObj)
        
        
        activityObj = Activity(name: "Galary Trail at the Royal Ontario Museum", desciption: "The Royal Ontario Museum, known as the ROM, is one of Canada's premier museums and one of the top tourist attractions in Ontario, with an international reputation for excellence. ", price: 29.99, rating: 5, host: "416-237-0974", photo1: "rom1", photo2: "rom2")
        self.activitiesList.append(activityObj)
        
        activityObj = Activity(name: "Field Trip at Ripley's Aquarium of Canada", desciption: "One of Toronto's newest top attractions is the Ripley's Aquarium of Canada near the base of the CN Tower. This fabulous facility displays all kinds of marine life and is one of the most popular things to do in Toronto for families.", price: 14.99, rating: 5, host: "647-289-3317", photo1: "aqua1", photo2: "aqua2")
        self.activitiesList.append(activityObj)
        
        
        activityObj = Activity(name: "Sculpting Workshop at Art Gallery of Ontario", desciption: "The renowned Art Gallery of Ontario (AGO) is one of the largest museums in North America. The collection of more than 95,000 pieces includes works from around the world, from European masterpieces to contemporary art.", price: 39.99, rating: 4, host: "419-523-9002", photo1: "ago1", photo2: "ago2")
        self.activitiesList.append(activityObj)

    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView()
    }
}


struct CustomListTileView : View{
    
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
                    .font(.system(size: 15))
                    
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(Color(UIColor(named: "TextTileColor") ?? UIColor(Color.black)))
        .onTapGesture {
            print(#function, "\(activity.name) selected")
        }
        
        
    }
}
