//
//  newMatches.swift
//  Smash Elo
//
//  Created by Robert Chung on 12/31/16.
//  Copyright © 2016 Robert Chung. All rights reserved.
//

import UIKit
import Firebase

class newMatchesViewController: UIViewController, UITextFieldDelegate {
    
    let matchName: LoginTextField = {
        let tf = LoginTextField()
        tf.placeholder = "Match Name"
        tf.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        tf.layer.borderColor = UIColor.init(red: 218/255, green: 223/255, blue: 225/255, alpha: 1).cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 4
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let makeMatchButton: UIButton = {
        let button = UIButton()
        button.isEnabled = true
        button.setTitle("Make Match", for: .normal)
        button.setTitle("Make Match", for: .disabled)
        if (button.isEnabled == false){
            button.alpha = 0.85
            button.backgroundColor = UIColor.init(red: 137/255, green: 196/255, blue: 244/255, alpha: 1)
            button.setTitleColor(.white, for: .disabled)
        }
        else{
            button.alpha = 1
            button.backgroundColor = .blue
            button.setTitleColor(.white, for: .normal)
        }
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(makeMatchButtonClick), for: .touchUpInside)
        
        return button
    }()
    
    
    // Firebase Database
    var ref: FIRDatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchName.delegate = self
        
        setupView()
        
        view.backgroundColor = .blue
        
        
        ref = FIRDatabase.database().reference()
        
    }

    func setupView(){
        view.addSubview(matchName)
        view.addSubview(makeMatchButton)
        
        
        matchName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        matchName.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        matchName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        matchName.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
        
        makeMatchButton.topAnchor.constraint(equalTo: matchName.bottomAnchor, constant: 15).isActive = true
        makeMatchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        makeMatchButton.widthAnchor.constraint(equalTo: matchName.widthAnchor).isActive = true

    }
    
    func makeMatchButtonClick(sender: Any){
        guard let matchNameInput = matchName.text else {
            print("Invalid Match Name")
            return
        }
        
        // unique id for the match created
        // I don't really know how to look it up tho
        let uuid = UUID().uuidString
//        let count = ref.child("count") as! Integer
        
        
        // Lookup table where first child will be a shortened id to look up
        // Within it you can find the uuid.
        // can later store that uuid in a variable and use it to lookup the actual match
        // just use a counter -- and then when wanting to add something you need to enter password
//        
//        self.ref.child("LookupTable").child(count).setValue(uuid)
//        self.ref.child("count").setValue()
        
        self.ref.child("Matches").child(uuid).setValue(matchNameInput)
        
    }
}
