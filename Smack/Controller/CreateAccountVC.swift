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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            avatarName = UserDataService.instance.avatarName
            userImg.image = UIImage(named: avatarName)
            
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func createAcctPressed(_ sender: Any) {
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        // unwrap optionals, return if they are empty
        guard let name = usernameText.text, usernameText.text != "" else { return }
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let pass = emailTxt.text, passTxt.text != "" else { return }
     
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered user!")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if (success) {
                        print("logged in user!",  AuthService.instance.authToken)
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            
                            print("created user!", UserDataService.instance.name, UserDataService.instance.avatarName)
                            
                            self.spinner.isHidden = true
                            self.spinner.stopAnimating()
                            
                            self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                        })
                    } else {
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        
                        print("failed to login user :(")
                    }
                })
            } else {
                self.spinner.isHidden = true
                self.spinner.stopAnimating()

                print("failed to register user :(")
            }

        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    func setupView() {
        spinner.isHidden = true

        usernameText.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        
        // watches for touches on the view and then dismisses the keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        // hides the keyboard
        view.endEditing(true)
    }
}
