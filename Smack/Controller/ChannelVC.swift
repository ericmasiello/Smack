//
//  ChannelVC.swift
//  Smack
//
//  Created by Eric Masiello on 1/20/18.
//  Copyright © 2018 Eric Masiello. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        // listen for NOTIF_USER_DATA_DID_CHANGE messages
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.createUIColor(fromString: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }
        
        return ChannelCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}

    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @objc func userDidChange(_ notif: Notification) {
        setupUserInfo()
    }
}
