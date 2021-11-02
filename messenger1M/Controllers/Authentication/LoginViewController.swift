//
//  LoginViewController.swift
//  messenger1M
//
//  Created by M's MacBook  on 28/10/2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var beeB: UIBarButtonItem!
    @IBOutlet weak var emailS: UITextField!
    @IBOutlet weak var PasswordS: UITextField!
    
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
                return
            }
            let user = result.user
            print("logged in user: \(user)")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConversationID") as! ConversationViewController
            self.present(vc, animated: true, completion: nil)
        })
    }
}
