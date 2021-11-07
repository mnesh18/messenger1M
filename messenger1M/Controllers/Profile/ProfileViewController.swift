//
//  ProfileViewController.swift
//  messenger1M
//
//  Created by M's MacBook  on 28/10/2021.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    let data = ["Log Out"]

    @IBAction func LogUotBtn(_ sender: UIButton) {
        Logout()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func Logout() {
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction((UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
                        // action that is fired once selected
        
                        guard let self = self else {
                            return
                        }
                        do {
        try FirebaseAuth.Auth.auth().signOut()
//         let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginID") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
        
                        } catch {
                            print("Failed Logout")
                        }
        })))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    present(actionSheet, animated: true)
    }

}
