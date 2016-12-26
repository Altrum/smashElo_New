//
//  LoginViewController.swift
//  smashElo3
//
//  Created by Robert Chung on 12/25/16.
//  Copyright © 2016 Altrum. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var LoginImage: UIImageView!
    
    let inputContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .lightGray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        return containerView
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.layer.cornerRadius = 4
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.layer.cornerRadius = 4
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("Login", for: .normal)
        button.setTitle("Login", for: .disabled)
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
        
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // I BELIEVE THESE ARE CORRECT FOR DELEGATION
        usernameTextField.delegate = self
        passwordTextField.delegate = self

        view.addSubview(inputContainerView)
        setupContainerView()
        checkLoginAvailable()

    }
    
    func setupContainerView() {
        // set x, y, height, width for
        // inputContainerView
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.topAnchor.constraint(equalTo: LoginImage.bottomAnchor).isActive = true
        inputContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        inputContainerView.addSubview(usernameTextField)
        inputContainerView.addSubview(passwordTextField)
        inputContainerView.addSubview(loginButton)
        
        // ---------------------------------------------------- //
        // --- Constraints for textFields in InputContainer --- //
            // usernameTextField constraints
        usernameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 30).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 30).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: -60).isActive = true

            // passWordTextField constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 30).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: -60).isActive = true
        // -------- END OF Constraints for textfields --------- //
        // ---------------------------------------------------- //
        
        
        // ------------------------------------------------ //
        // --- Constraints for Button in InputContainer --- //
        loginButton.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 30).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: -60).isActive = true
        // ------ END OF Constraints for loginButton ------ //
        // ------------------------------------------------ //

        
    }
    
    // TODO FIRGURE IT OUT
    func checkLoginAvailable(){
 
        if usernameTextField.text
        loginButton.isEnabled = false
        }
        else{
            loginButton.isEnabled = true
        }

    }


}
