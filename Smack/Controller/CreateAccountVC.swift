//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Eric Masiello on 1/23/18.
//  Copyright © 2018 Eric Masiello. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
}
