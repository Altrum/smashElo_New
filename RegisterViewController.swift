//
//  RegisterViewController.swift
//  smashElo3
//
//  Created by Robert Chung on 12/26/16.
//  Copyright © 2016 Altrum. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI
import FBSDKLoginKit


class RegisterViewController: UIViewController, FBSDKLoginButtonDelegate {

    
    let loginButton: FBSDKLoginButton = {
        
        let loginButton = FBSDKLoginButton()
        return loginButton
    }()
    
    
    // =================================================
    // TODO
    // Implement email sign in -- How to make it pretty?
    // For now, we will use make users manually until the actual elo system and database is set
    // =================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginButton.delegate = self
        
        
        // Firebase UI Configuration part -- I don't know where to put this above code
        // Do i put it here or app delegate?
        // Also the bottom function -- what do I really do with that?
        
        
        
        
        print("Loaded RegisterViewController")
        view.backgroundColor = .gray

    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        
        if result.isCancelled {
            return
        }
        
        // This makes sure they can't access button before it transitions
        // However, I feel like theres better ways to do this
        // I think I could make the login button custom to indicate working with spinner
        //      and then make it untouchable -- TODO
        loginButton.removeFromSuperview()
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                if error != nil{
                    print(error)
                    return
                }
                
                self.successfulRegister()
                
            }
            
            print("Facebook Login Successful")
        }
    
    
    // Goes to tabBar Controller if authenticated
    func successfulRegister(){

        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar")
        navigationController?.pushViewController(nextVC, animated: true)
        
        print("Helo")
       
    }
}
