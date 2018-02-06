//
//  LoginVC.swift
//  Smack
//
//  Created by Eric Masiello on 1/20/18.
//  Copyright © 2018 Eric Masiello. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func toggleSpinner(_ show: Bool) {
        spinner.isHidden = !show
        if (show) {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
    
    func showSpinner() {
        return toggleSpinner(true)
    }
    
    func hideSpinner() {
        return toggleSpinner(false)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        showSpinner()
        
        guard let email = userNameTxt.text , userNameTxt.text != "" else { return }
        guard let pass = passwordTxt.text , passwordTxt.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        debugPrint("Failed to findUserByEmail")
                    }
                    self.hideSpinner()
                })
            } else {
                debugPrint("Failed to loginUser")
                self.hideSpinner()
            }
        }
        
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        self.hideSpinner()
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
    }
}
