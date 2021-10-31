//
//  RegistractionViewController.swift
//  messenger1M
//
//  Created by M's MacBook  on 28/10/2021.
//

import UIKit
import AVFoundation

class RegistractionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var ImgPhoto: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func BtnTakePhoto(_ sender: Any) {
        
        showPhotoAlert()
    }
    
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
        Pic.allowsEditing = false  /* لقص الصورة والتعديل عليها */
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
        guard  let photo = info[.originalImage] as? UIImage else{
            print("Photo Not Found.!!")
            return
        }
        ImgPhoto.image = photo
    } /* Info هنا هو القاموس اللي بجيب منه الصور */
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
