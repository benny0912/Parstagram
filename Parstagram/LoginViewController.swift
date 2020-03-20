//
//  ViewController.swift
//  Parstagram
//
//  Created by Benny Ooi Kean Hoe on 3/12/20.
//  Copyright © 2020 Benny Ooi. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onSignIn(_ sender: UIButton) {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    if(user != nil) {
                       self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                   }
                }
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: UIButton) {
        
        let user = PFUser()
        if let username = usernameTextField.text, let password = passwordTextField.text {
            user.username = username
            user.password = password
            
            user.signUpInBackground { (success, error) in
                if success {
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                } else{
                    if let err = error {
                        print("Error: \(err.localizedDescription)")
                    }
                }
            }
        }
    }
}

