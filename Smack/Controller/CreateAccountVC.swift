//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Andras on 27/10/17.
//  Copyright © 2017 Andras. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }

    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    

}
