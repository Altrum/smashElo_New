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


// Might reset database data if user is already authorized via facebook
// Or email
// May need to provide code to avoid this error
// TODO (Check)

class RegisterViewController: UIViewController, FBSDKLoginButtonDelegate {

    
    let loginButton: FBSDKLoginButton = {
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    
    let registerEmailButton: UIButton = {
        // make it pretty later
        // TODO
        let button = UIButton()
        button.setTitle("Sign up with Email", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(registerEmail), for: .touchUpInside)
        
        return button
    }()

    // firebase database reference
    var ref: FIRDatabaseReference!
    
    
    // =================================================
    // TODO
    // Implement email sign in -- How to make it pretty?
    // For now, we will use make users manually until the actual elo system and database is set
    // =================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        loginButton.delegate = self
        
        ref = FIRDatabase.database().reference()
        
        
        
        print("Loaded RegisterViewController")
        view.backgroundColor = .gray

    }
    
    
    
    func setupView(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.addSubview(loginButton)
        view.addSubview(registerEmailButton)
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        registerEmailButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15).isActive = true
        registerEmailButton.leftAnchor.constraint(equalTo: loginButton.leftAnchor).isActive = true
        registerEmailButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor).isActive = true

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
                    print(error as Any)
                    return
                }
                
                let player = PlayerObject.init()
                
                // Getting data from FacebookSDK for name, email, and photo
                // Facebook presents data in a json way
                
                let ref = FIRDatabase.database().reference(fromURL: "https://smashelonew.firebaseio.com/")
                ref.child("users").observeSingleEvent(of: FIRDataEventType.value, with: { (snapshot) in
                    if snapshot.hasChild((user?.uid)!){
                        return
                    }
                    else{
                        
                        // Get stuff from facebook and put it in
                        if (FBSDKAccessToken.current() != nil) {
                            FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"email,name"]).start(completionHandler: { (connection, result, error) in
                                if error != nil {
                                    print(error as Any)
                                    return
                                }
                                else {
                                    if let userData = result as? NSDictionary {
                                        
                                        let userName = userData["name"] as! String
                                        let userEmail = userData["email"] as! String
                                        
                                        player.name = userName
                                        player.email = userEmail
                                        
                                        self.registerToDatabase(user: user, player: player)
                                        
                                    }
                                    
                                    
                                    
                                }
                            })
                        } // end if
                    }
                }) // end observeSingleEvent
                
                self.successfulRegisterTransition()
                
            }
            
            print("Facebook Login Successful")
        }
    
    
    // Goes to tabBar Controller if authenticated
    func successfulRegisterTransition(){

        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "matches")
        let newNav = UINavigationController(rootViewController: nextVC)
        navigationController?.present(newNav, animated: true, completion: nil)
        
    }
    
    func registerToDatabase(user: FIRUser?, player: PlayerObject){
        let uid = user?.uid
        let firedataref = FIRDatabase.database().reference(fromURL: "https://smashelonew.firebaseio.com/")
        let userref = firedataref.child("users").child(uid!)
        let values = ["name": player.name, "email": player.email, "careerElo": player.careerElo, "careerWins": player.careerWins, "careerLosses": player.careerLosses, "careerTotalGames": player.careerTotalGames, "matches": player.matches] as [String : Any]
        
        userref.updateChildValues(values, withCompletionBlock: { (error, userref) in
            if error != nil{
                print(error as Any)
                return
            }
        })
    }
    
    func registerEmail(_sender: Any){
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registeremail")
        navigationController?.pushViewController(VC, animated: true)
    }
}
