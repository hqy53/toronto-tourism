//
//  User.swift
//  MADS4003-Proj-G03
//
//  Created by Qianying Huang on 2023/3/5.
//

import Foundation

// ObservableObject protocol allows views that use User class to be updated automatically whenever any of its properties are changed.
class User: Identifiable, ObservableObject {
    let id = UUID()  // unique identifier
    var email: String
    var password: String
    
    init(){
        self.email = ""
        self.password = ""
    }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
