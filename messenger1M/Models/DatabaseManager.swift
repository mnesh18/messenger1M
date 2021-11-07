//
//  DatabaseManager.swift
//  messenger1M
//
//  Created by M's MacBook  on 01/11/2021.
//

import Foundation
import FirebaseDatabase
import Firebase

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
//    let profilePicURL: String
    
    var safeEmail: String {
            var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
            safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
            return safeEmail
        }
}

public enum StorageErrors: Error {
    case failedToUpload
    case FailedToGetDownloadUrl
}

final class DatabaseManger {
    
    static let shared = DatabaseManger()
    
    private let database = Database.database().reference()
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    private let storage = Storage.storage().reference()
        
//    public func test() {
//        // NoSQL - JSON (keys and objects)
//        // child refers to a key that we want to write data to
//        // in JSON, we can point it to anything that JSON supports - String, another object
//        // for users, we might want a key that is the user's email address
//
//        //database.child("foo").setValue(nil)      or
//        database.child("foo").setValue(["something":true])
//    }
}
                
// MARK: - account management
extension DatabaseManger { /* insert new user to Database */
    public func insertUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue(["first_name":user.firstName,"last_name":user.lastName,"email":user.emailAddress])
    }
    
//    public func validateNewUser ( with email: String, completion: @escaping ((Bool) -> Void) ){
//
//    }
    

        public func uploadProfilePicture(data: Data, fileName: String, completion: @escaping UploadPictureCompletion){
                // return a string of the download URL
                // if we succeed, return a string, otherwise return error
    
            storage.child("images/\(fileName)/img").putData(data, metadata: nil) { metadata, error in /* حطيت سلاش قبل امج عشان يفتحها صورة طبيعية*/
                    guard error == nil else {
                        // failedcopy
                        print("failed to upload data to firebase for picture")
                        completion(.failure(StorageErrors.failedToUpload))
                        return
                    }
                    print("successfully uploaded picture to Firebase Storage ")
                     completion(.success("SUCCESS"))
                }
        }
                    
                    
 
    public func UserExists ( with email: String, completion: @escaping ((Bool) -> Void) ){ /* call this func on register before register new user*/
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
        
        
    }
    
}
