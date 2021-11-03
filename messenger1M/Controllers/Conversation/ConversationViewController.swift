//
//  ConversationViewController.swift
//  messenger1M
//
//  Created by M's MacBook  on 28/10/2021.
//

import UIKit
import Firebase


class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        DatabaseManger.shared.test()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    private func validateAuth(){
        if FirebaseAuth.Auth.auth().currentUser == nil {
                    // present login view controller mmmmmmmmm
                    let vc = LoginViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    present(nav, animated: false)
                }
    }
    
    

}
