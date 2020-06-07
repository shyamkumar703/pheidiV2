//
//  RadioButton.swift
//  teamConnect
//
//  Created by Shyam Kumar on 8/10/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import Foundation
import UIKit

class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
        self.layer.borderColor = pheidiColors.pheidiTeal.cgColor
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
            //toggleButton()
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = pheidiColors.pheidiTeal.cgColor
            } else {
                self.layer.borderColor = pheidiColors.pheidiTeal.cgColor
            }
        }
    }
}


