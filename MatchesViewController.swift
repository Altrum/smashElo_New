//
//  MatchesViewController.swift
//  smashElo3
//
//  Created by Robert Chung on 12/30/16.
//  Copyright © 2016 Altrum. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class MatchesViewController: UIViewController {
    
    // Firebase Database
    var ref: FIRDatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Firebase database
        ref = FIRDatabase.database().reference()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMatch))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.title = "Matches"
        
    }
    

    func addMatch(_ sender: Any) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newMatch")
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func handleLogout(_ sender: Any){
        
        // logout and handle error if it catches error
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        // logout of facebook if logged in with facebook
        let fbManager = FBSDKLoginManager()
        try! fbManager.logOut()
        
        // Honestly don't know what I did here but it worked
        // WHOOO
        // TODO LEARN(?)
        if let backVC = self.storyboard?.instantiateViewController(withIdentifier: "login") {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let navigator = UINavigationController(rootViewController: backVC)
            
            appDelegate.window?.rootViewController! = navigator
            UIView.transition(with: appDelegate.window!, duration: 0.4, options: .transitionFlipFromLeft, animations: { appDelegate.window?.rootViewController = navigator}, completion: nil)
        }
    }
}
