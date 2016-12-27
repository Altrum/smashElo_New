//
//  LoginTextField.swift
//  smashElo3
//
//  Created by Robert Chung on 12/27/16.
//  Copyright © 2016 Altrum. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //let font = UIFont(name: "Avenir", size: 16)!
        //let attributes = [
        //    NSForegroundColorAttributeName: UIColor.lightGray,
        //    NSFontAttributeName : font]
        
        //self.attributedPlaceholder =
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Adding padding to left side
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.font = UIFont(name: "Avenir", size: 16)
        
        
    }
    
}
