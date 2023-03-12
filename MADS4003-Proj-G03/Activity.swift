//
//  Activity.swift
//  MADS4003-Proj-G03
//
//  Created by anthony on 2023-03-02.
//

import Foundation

struct Activity : Identifiable, Codable{
    
    var id = UUID()
    var name : String = ""
    var description : String = ""
    var price : Double = 0.0
    var rating : Int = 0
    var host : String = ""
    var photo1 : String = ""
    var photo2 : String = ""
    
    
    init(){
        self.name = "NA"
        self.description = "NA"
        self.price = -1.0
        self.rating = -1
        self.host = "NA"
        self.photo1 = "default1"
        self.photo2 = "default2"
    }
    
    init(name : String, desciption : String, price : Double, rating : Int, host : String, photo1 : String, photo2 : String){
        self.name = name
        self.description = desciption
        self.price = price
        self.rating = rating
        self.host = host
        self.photo1 = photo1
        self.photo2 = photo2
    }
    
}


