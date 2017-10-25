//
//  ChannelVC.swift
//  Smack
//
//  Created by Andras on 24/10/17.
//  Copyright © 2017 Andras. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

   

}
