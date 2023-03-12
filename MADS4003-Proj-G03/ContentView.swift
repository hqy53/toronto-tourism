//
//  ContentView.swift
//  MADS4003-Proj-G03
//
//  Created by anthony on 2023-03-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        


        NavigationView{
            
            
            TabView{
                ActivitiesView().tabItem{
                    Image(systemName: "fanblades.fill")
                    
                    Text("ACTIVITIES")
                    
                }
                
                FavoritesView().tabItem{
                    Image(systemName: "heart.fill")
                    
                    Text("FAVORITES")
                }
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
