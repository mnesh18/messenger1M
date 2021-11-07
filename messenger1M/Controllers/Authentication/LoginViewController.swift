//
//  LoginViewController.swift
//  messenger1M
//
//  Created by M's MacBook  on 28/10/2021.
//

import UIKit
import Firebase
import FacebookLogin
import FacebookCore
//import SwiftUI
import GoogleSignIn


class LoginViewController: UIViewController {
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    
    
    @IBOutlet weak var beeB: UIBarButtonItem!
    @IBOutlet weak var emailS: UITextField!
    @IBOutlet weak var PasswordS: UITextField!
    @IBAction func FacebookLogin(_ sender: UIButton) {
        FacebookLoginMethod()
    }
    @IBAction func GoogleLogin(_ sender: UIButton) {
        GoogleLoginMethod()
    }
    
    func FacebookLoginMethod() {
        let loginManger = LoginManager()
        loginManger.logOut()
        loginManger.logIn(permissions: [.publicProfile, .email, .userBirthday, .userPhotos, .userFriends, .userEvents, .userGender], viewController: self) { loginResult in
            
            switch loginResult {
                
            case .failed(let error):
//                HUD.hide()
                print(error)
            case .cancelled:
//                HUD.hide()
                print("User Cancelled Login.")
            case .success( _, _, _):
                print("Logged in:")
                self.getFBUserData()
            }
        }
    }
    
    func GoogleLoginMethod () {
//        GIDSignIn.sharedInstance.signIn(
//            with: "CLIENT_ID",
//            presenting: self // your view controller
//        ) { user, error in
//            if let token = user?.authentication.idToken {
//                completionHandler(token, nil)
//                return
//            }
//            guard let error = error as? GIDSignInError else {
//                fatalError("No token and no GIDSignInError: \(String(describing: error))")
//            }
//            completionHandler(nil, error)
//        }
    }
    
    func getFBUserData (){
        if((AccessToken.current) != nil){
            
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email, gender"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    let dict = result as! [String : AnyObject]
                    print(result!)
                    print(dict)
                    let picutreDic = dict as NSDictionary
                    let tmpURL1 = picutreDic.object(forKey: "picture") as! NSDictionary
                    let tmpURL2 = tmpURL1.object(forKey: "data") as! NSDictionary
                    let finalURL = tmpURL2.object(forKey: "url") as! String
                    
                    
                    let nameOfUser = picutreDic.object(forKey: "name") as! String
                    self.lblUserName.text = nameOfUser
//
                    var tmpEmailAdd = ""
                    if let emailAddress = picutreDic.object(forKey: "email") {
                        tmpEmailAdd = emailAddress as! String
                        self.lblUserEmail.text = tmpEmailAdd
                    }
                    else {
                        var usrName = nameOfUser
                        usrName = usrName.replacingOccurrences(of: " ", with: "")
                        tmpEmailAdd = usrName+"@facebook.com"
                    }
                    self.navigationController?.setNavigationBarHidden(true, animated: true)
                    self.performSegue(withIdentifier: "GotoChatStory", sender: self)
                }
                print(error?.localizedDescription as Any)
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func LoginBtn(_ sender: UIButton) {
        signinUser()
    }
    func signinUser() {
        // Firebase Login
        FirebaseAuth.Auth.auth().signIn(withEmail: emailS.text!, password: PasswordS.text!, completion: { authResult, error in
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email \(String(describing: self.emailS))")
                self.alertUserLoginError(message: "\(error!.localizedDescription)")
                return
            }
            let user = result.user
            print("logged in user: \(user)")
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.performSegue(withIdentifier: "GotoChatStory", sender: self)
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TapbarID") as! ChatViewController
//            self.present(vc, animated: true, completion: nil)
            
        })
    }
    func alertUserLoginError (message: String = " Please enter Signup to create a new account") {
        let alert = UIAlertController(title: "Oops", message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
}
