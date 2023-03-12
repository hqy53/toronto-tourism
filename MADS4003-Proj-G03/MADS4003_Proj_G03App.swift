//
//  MADS4003_Proj_G03App.swift
//  MADS4003-Proj-G03
//
//  Created by anthony on 2023-03-02.
//

import SwiftUI

@main
struct MADS4003_Proj_G03App: App {
    
    var currUser : User = User()
    
    var body: some Scene {
        WindowGroup {

            LoginView().environmentObject(currUser)

        }
    }
}
