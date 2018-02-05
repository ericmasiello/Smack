//
//  ProfileVC.swift
//  Smack
//
//  Created by Eric Masiello on 2/4/18.
//  Copyright © 2018 Eric Masiello. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    // Outlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        userEmail.text = UserDataService.instance.email
        userName.text = UserDataService.instance.name
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.createUIColor(fromString: UserDataService.instance.avatarColor)
        
        // close the modal when the user clicks on the bgView
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTapped(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTapped(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
