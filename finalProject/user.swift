//
//  user.swift
//  finalProject
//
//  Created by Seak Yith on 11/26/21.
//

import Foundation
import SQLite

// User Class
class User{
    var username : String
    var password : String
    var email : String
    
    init(user : String, pass : String, email: String){
        self.username = user
        self.password = pass
        self.email = email
    }
}
// Connecting Databse
class Database {
    var conn : Connection!
    
    init (){
        let rootPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let dbPath = rootPath.appendingPathComponent("diary.sqlite").path
        conn = try! Connection(dbPath)
        
    }
}
