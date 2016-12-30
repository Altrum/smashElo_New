//
//  LoginViewController.swift
//  smashElo3
//
//  Created by Robert Chung on 12/25/16.
//  Copyright © 2016 Altrum. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI


class LoginViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var LoginImage: UIImageView!
    
    let inputContainerView: UIView = {
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
        button.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        
        return button
    }()
    
    let registerLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Need an account?"
        label.textColor = UIColor.init(red: 189/255, green: 195/255, blue: 199/255, alpha: 1) // might have to put /255
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
        
    }()
    
    let registerTextButton: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.textColor = UIColor.init(red: 89/255, green: 171/255, blue: 227/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        
        // I want to do this but the delegation statement wont work unless in viewDidLoad()
        // Hmm TODO??
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toRegisterScreen))
//        label.addGestureRecognizer(tapGesture)
//        tapGesture.delegate = self
        
        
        return label
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginImage.image = #imageLiteral(resourceName: "ssb4logo")
        
        // Hide navigation bar
        // might need for viewWillDisappear as well
        self.navigationController?.isNavigationBarHidden = true
        
        
        // I BELIEVE THESE ARE CORRECT FOR DELEGATION
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Tap gesture for register button
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toRegisterScreen))
        registerTextButton.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
                

        
        view.addSubview(inputContainerView)
        setupContainerView()

    }
    
    func setupContainerView() {
        // set x, y, height, width for
        // inputContainerView
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.topAnchor.constraint(equalTo: LoginImage.bottomAnchor).isActive = true
        inputContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(passwordTextField)
        inputContainerView.addSubview(loginButton)
        inputContainerView.addSubview(registerLabel)
        inputContainerView.addSubview(registerTextButton)
        
        // ---------------------------------------------------- //
        // --- Constraints for textFields in InputContainer --- //
            // emailTextField constraints
        emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 30).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 30).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: -60).isActive = true

            // passWordTextField constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 30).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15).isActive = true
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
        
        
        registerLabel.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor).isActive = true
        registerLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15).isActive = true
        
        registerTextButton.leftAnchor.constraint(equalTo: registerLabel.rightAnchor, constant: 8).isActive = true
        registerTextButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15).isActive = true

        
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
            loginButton.isEnabled = true
            
            loginButton.alpha = 1
            loginButton.backgroundColor = UIColor.init(red: 89/255, green: 171/255, blue: 227/255, alpha: 1)
            loginButton.setTitleColor(.white, for: .normal)
        }
        else{
            loginButton.isEnabled = false

            loginButton.alpha = 0.85
            loginButton.backgroundColor = UIColor.init(red: 137/255, green: 196/255, blue: 244/255, alpha: 1)
            loginButton.setTitleColor(.white, for: .disabled)

        }

    }
    
    // TODO -- need to use firebase here
    func loginClicked(sender: UIButton!){
        guard let email = emailTextField.text else {
            print("Invalid Email")
            return
        }
        guard let password = passwordTextField.text else {
            print("Invalid Password")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                
                // Show error message if not authenticated
                let errorAlert = UIAlertController.init(title: "Invalid Login!", message: "Please check your login Information and try again.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Okay", style: .default)
                errorAlert.addAction(okAction)
                self.present(errorAlert, animated: true, completion: nil)
                
                return
            }
            
            // else go to the tabBar Controller
            self.loginSuccess()
        }
    }

    
    func toRegisterScreen(sender: AnyObject){
        
        print("toRegisterScreen!")

        let registerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "register")
        navigationController?.pushViewController(registerVC, animated: true)
        
    }

    
    func loginSuccess(){
        
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar")
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    // MORE TODO
    // Have to do authentication for firebase with login/register
    // I think matches should have its own branch -- to be seen globally, but you would need keys to access matches??
    //      Kind of like discord channels per se
    // This way I can login and have matches on my phone synced with a match on someone else's phone.
    // Not sure if this is how to do this
    // Should also dismiss the keyboard when pressed outside i believe
    
    

}
