//
//  DatabaseManager.swift
//  messenger1M
//
//  Created by M's MacBook  on 01/11/2021.
//

import Foundation
import FirebaseDatabase

final class DatabaseManger {
    
    static let shared = DatabaseManger()
    
    
    private let database = Database.database().reference()
        
    
    
    public func test() {
        // NoSQL - JSON (keys and objects)
        // child refers to a key that we want to write data to
        // in JSON, we can point it to anything that JSON supports - String, another object
        // for users, we might want a key that is the user's email address
        
        //database.child("foo").setValue(nil)      or
        database.child("foo").setValue(["something":true])
    }
    
//    {
//        "foo": "
//    }
}
