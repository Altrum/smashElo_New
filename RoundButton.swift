//
//  roundButton.swift
//  smashElo2
//
//  Created by Robert Chung on 12/22/16.
//  Copyright © 2016 Altrum. All rights reserved.
//
//  More of an extension on UIButton where we just have a round button
//  Made this so that autolayout would work
//

import UIKit

class RoundButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.clipsToBounds = true
    }
}
