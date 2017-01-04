//
//  RegisterEmail.swift
//  Smash Elo
//
//  Created by Robert Chung on 1/3/17.
//  Copyright © 2017 Robert Chung. All rights reserved.
//

import UIKit

class RegisterEmailController: UIViewController {
    
    
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
//        button.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        
        return button
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}

// TODO 1/4/16
// Register user with email
// Also make the button into enable when theres items in fields

