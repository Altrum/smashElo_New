//
//  RegisterEmail.swift
//  Smash Elo
//
//  Created by Robert Chung on 1/3/17.
//  Copyright © 2017 Robert Chung. All rights reserved.
//

import UIKit
import Firebase

class RegisterEmailController: UIViewController, UITextFieldDelegate {
    
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        return containerView
    }()

    let emailTextField: LoginTextField = {
        let tf = LoginTextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        tf.layer.borderColor = UIColor.init(red: 218/255, green: 223/255, blue: 225/255, alpha: 1).cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 4
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: LoginTextField = {
        let tf = LoginTextField()
        tf.placeholder = "Password"
        tf.layer.cornerRadius = 4
        tf.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        tf.layer.borderColor = UIColor.init(red: 218/255, green: 223/255, blue: 225/255, alpha: 1).cgColor
        tf.layer.borderWidth = 1
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("Register", for: .normal)
        button.setTitle("Register", for: .disabled)
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
        button.addTarget(self, action: #selector(registerClicked), for: .touchUpInside)
        
        return button
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setupView()
        
        
    }
    
    // setup the view controller programmatically
    
    func setupView(){
        
        view.addSubview(containerView)

        // set x, y, height, width for
        // inputContainerView
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(registerButton)

        
        // ---------------------------------------------------- //
        // --- Constraints for textFields in InputContainer --- //
        // emailTextField constraints
        emailTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30).isActive = true
        emailTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -60).isActive = true
        
        // passWordTextField constraints
        passwordTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -60).isActive = true
        // -------- END OF Constraints for textfields --------- //
        // ---------------------------------------------------- //
        
        
        // ------------------------------------------------ //
        // --- Constraints for Button in InputContainer --- //
        registerButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30).isActive = true
        registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -60).isActive = true
        // ------ END OF Constraints for loginButton ------ //
        // ------------------------------------------------ //
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkLoginAvailable(sender: textField)
    }
    
    
    // Checks to see if forms are filled before allowoing login button
    // Works kind of but it prematurely allows button with 0 charas in a text field
    // TODO I GUESS
    func checkLoginAvailable(sender: AnyObject){
        
        
        // Could probably just adjust alpha values instead of assigning new colors
        // TODO possibly
        if ((emailTextField.hasText) && (passwordTextField.hasText))
            || (emailTextField.isEditing && passwordTextField.hasText)
            || (passwordTextField.isEditing && emailTextField.text != ""){
            registerButton.isEnabled = true
            
            registerButton.alpha = 1
            registerButton.backgroundColor = UIColor.init(red: 89/255, green: 171/255, blue: 227/255, alpha: 1)
            registerButton.setTitleColor(.white, for: .normal)
        }
        else{
            registerButton.isEnabled = false
            
            registerButton.alpha = 0.85
            registerButton.backgroundColor = UIColor.init(red: 137/255, green: 196/255, blue: 244/255, alpha: 1)
            registerButton.setTitleColor(.white, for: .disabled)
            
        }
        
    }
    
    
    func registerClicked(_sender: Any){
        guard let email = emailTextField.text else {
            print("invalid email text")
            return
        }
        guard let pass = passwordTextField.text else {
            print("invalid psswd text")
            return
        }
        
        // Create user
        // Also checks to see validity
        // Also adds to database
        FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
            if error != nil{
                if let errorCode = FIRAuthErrorCode(rawValue: error!._code){
                    self.errorPopup(error: errorCode)
                }
            }
            else{
                
                // add to database
                let player = PlayerObject.init(name: "Player", email: email)
                self.addToDatabase(user: user, player: player)
                let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "matches")
                self.navigationController?.pushViewController(VC, animated: true)
            }
        })
        
    }
    
    // Function to handle errors from the register
    // Does a popup
    func errorPopup(error: FIRAuthErrorCode){
        
       let errorAlert = UIAlertController.init(title: "Email is already in use", message: "Please check your information and try again.", preferredStyle: .alert)
        
        
        switch error {
        case .errorCodeEmailAlreadyInUse:
            errorAlert.title = "Email Already Registered!"
        case .errorCodeNetworkError:
            errorAlert.title = "Network Error"
            errorAlert.message = "Please check your connection and try again"
        case .errorCodeInvalidEmail:
            errorAlert.title = "Invalid Email"
            errorAlert.message = "Please check your email again"
        case .errorCodeWeakPassword:
            errorAlert.title = "Weak Password"
            errorAlert.message = "Make your password stronger"
        //below might need later
        //case .errorCodeAccountExistsWithDifferentCredential
        default:
            errorAlert.title = "Error!"
            errorAlert.message = "There was an error. Please try again"
        }
        
        let okAction = UIAlertAction(title: "Dismiss", style: .default)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true, completion: nil)

    }
    
    // Function to add the user to the database
    func addToDatabase(user: FIRUser?, player: PlayerObject){
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
}

// TODO 1/4/16
// Register user with email
// Also make the button into enable when theres items in fields
// figure out git stuff holy


