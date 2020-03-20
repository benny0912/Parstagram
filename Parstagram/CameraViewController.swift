//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Benny Ooi Kean Hoe on 3/19/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: UIButton) {
        let post = PFObject(className: "Posts")
        
       
        let imageData = imageVIew.image?.pngData()
        if let imgData = imageData, let caption = commentTextField.text {
            let file = PFFileObject(name:"temp.png",data: imgData)
            post["author"] = PFUser.current()!
            post["caption"] = caption
            post["image"] = file
            
            post.saveInBackground { (success, error) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                    print("saved!")
                } else {
                    if let err = error {
                        print("Error: \(err.localizedDescription)")
                    }
                }
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        imageVIew.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
