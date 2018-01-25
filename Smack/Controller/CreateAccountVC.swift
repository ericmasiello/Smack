//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Eric Masiello on 1/23/18.
//  Copyright © 2018 Eric Masiello. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    // Outlets
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAcctPressed(_ sender: Any) {
        // unwrap optionals, return if they are empty
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let pass = emailTxt.text, passTxt.text != "" else { return }
     
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered user!")
            } else {
                print("failed to register user :(")
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
}
