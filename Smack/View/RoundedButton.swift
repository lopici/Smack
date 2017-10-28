//
//  RoundedButton.swift
//  Smack
//
//  Created by Andras on 28/10/17.
//  Copyright © 2017 Andras. All rights reserved.
//

import UIKit

 @IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
  
    override func awakeFromNib() {
        self.setupView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
}
