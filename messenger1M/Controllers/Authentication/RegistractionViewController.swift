//
//  RegistractionViewController.swift
//  messenger1M
//
//  Created by M's MacBook  on 28/10/2021.
//

import UIKit
import Firebase

class RegistractionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var ImgPhoto: UIImageView!
    @IBOutlet weak var FirstNameR: UITextField!
    @IBOutlet weak var LastNameR: UITextField!
    
    @IBOutlet weak var emailR: UITextField!
    
    @IBOutlet weak var PasswordR: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func RegisterBtn(_ sender: UIButton) {
        signupUser()
    }
    @IBAction func BtnTakePhoto(_ sender: Any) {
        
        showPhotoAlert()
    }
    
//     here i will try call "UserExists func"
    
//    DatabaseManger.shared.UserExists()(with: emailR, completion: { exists in
//        guard !exists else {
////            user already exists
//            return
//        }
//        FirebaseAuth.Auth.auth().createUser(withEmail: emailR, password: PasswordR, completion: { [weak self] authResult, error in
//            guard let strongSelf = self else {
//                return
//            }
//            guard authResult != nil, error == nil else {
//                print("Error Cureating User")
//                return
//            }
//            DatabaseManger.shared.insertUser(with: ChatAppUser(firstName: FirstNameR, lastName: LastNameR, emailAddress: emailR))
//            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
//        })
//    })
    

    
     func alertUserLoginError (message: String = "you already have account please enter Signin to Login") {
         let alert = UIAlertController(title: "Oops", message: message , preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
         
         present(alert, animated: true)
     }
    
//    ========================================
    
    func signupUser () {
        Auth.auth().createUser(withEmail: emailR.text!, password: PasswordR.text!) { [self] authResult, error in
            if let error = error {
                alertUserLoginError(message: "\(error.localizedDescription)")
                print("Error status: \(error.localizedDescription)")
            } else {
                DatabaseManger.shared.insertUser(with: ChatAppUser(firstName: FirstNameR.text!, lastName: LastNameR.text!, emailAddress: self.emailR.text!)) /* IDK */
                let pictureData = ImgPhoto.image?.jpegData(compressionQuality: 0.5)
                let storageFileName = Auth.auth().currentUser?.email
                DatabaseManger.shared.uploadProfilePicture(data: pictureData!, fileName: storageFileName!) { (result: Result<String, Error>) in
                  switch result {
                  case .success(_):
                      
                      break
                  case .failure(let error):
                      alertUserLoginError(message: error.localizedDescription)
                      break
                  }
                }
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConversationID") as! ConversationViewController
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    

    
//    @objc private func didTapRegister() {
//        let vc = RegistractionViewController()
//        vc.title = " Create Account "
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//    extension RegistractionViewController: UITextFieldDelegate {
//
//    }
    
    func showPhotoAlert(){
        let alert = UIAlertController(title: "Take Photo From: ", message: nil, preferredStyle: .actionSheet)
//        here message: " " with keep place for it ((OR)) nil without keep place for message
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.getPhoto(type: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            self.getPhoto(type: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel ", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func getPhoto(type: UIImagePickerController.SourceType){
        let Pic = UIImagePickerController()
        Pic.sourceType = type
        Pic.allowsEditing = true  /* لقص الصورة والتعديل عليها */
        Pic.delegate = self
        present(Pic, animated: true, completion: nil) /*  هنا فتحنا imageController لازم الحين نسوي لها ديسميس تحت بدالة الديدفينيش*/
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
//        if let photo = info[.originalImage] as? UIImage {
//            ImgPhoto.image = photo
//        } else {
//            print("Photo Not Found.!!")
//        }
//        إذا مابي أستخدم هنا if أقدر أستخدم بداله guard
        guard  let photo = info[.editedImage] as? UIImage else{
            print("Photo Not Found.!!")
            return
        }
        ImgPhoto.image = photo
    } /* Info هنا هو القاموس اللي بجيب منه الصور */
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
