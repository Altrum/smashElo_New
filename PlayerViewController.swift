//
//  PlayerViewController.swift
//  smashElo2
//
//  Created by Robert Chung on 12/20/16.
//  Copyright © 2016 Altrum. All rights reserved.
//

import UIKit
import Firebase

class PlayerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addPictureButton: RoundButton!
    @IBOutlet var addPlayerView: UIView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var favPlayerTextField: UITextField!
    
    var effect:UIVisualEffect!

    // Firebase Database
    var ref: FIRDatabaseReference!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        effect = visualEffect.effect
        visualEffect.effect = nil
        
        addPlayerView.layer.cornerRadius = 5

        ref = FIRDatabase.database().reference()

        
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        animateIn()
    }
    @IBAction func dismissPopup(_ sender: Any) {
        dismissScreen()
    }
    @IBAction func createNewPlayer(_ sender: Any) {
        guard let name = nameTextField.text else {
            print("Invalid Name")
            return
        }
        guard let favPlayer = favPlayerTextField.text else{
            print("Invalid fav player")
            return
        }
        // Add player to match here
        
    }
    
    
    func animateIn(){
        self.view.addSubview(addPlayerView)
        addPlayerView.center = self.view.center
        addPlayerView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        addPlayerView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffect.effect = self.effect
            self.addPlayerView.alpha = 1
            self.addPlayerView.transform = CGAffineTransform.identity
            
        }
    }
    func dismissScreen(){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffect.effect = nil
            self.addPlayerView.alpha = 0
            self.addPlayerView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (success:Bool) in
            self.addPlayerView.removeFromSuperview()
            self.addPictureButton.setImage(#imageLiteral(resourceName: "addPictureImage"), for: .normal)
        }
    }
    
    @IBAction func addPictureClick(_ sender: Any) {
        // Function to choose the picture from camera roll  //
        // Used in the popout option menu                   //
        func choosePicture(action: UIAlertAction){
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            
        }
        
        // Function to take picture from camera
        // Used in the popout option menu
        func takePicture(action: UIAlertAction){
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                let takePicture = UIImagePickerController()
                takePicture.delegate = self
                takePicture.sourceType = UIImagePickerControllerSourceType.camera;
                takePicture.allowsEditing = false
                self.present(takePicture, animated: true, completion: nil)
            }
            
        }
        
        // optionMenu
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let choosePictureAction = UIAlertAction(title: "Choose Picture", style: .default, handler: choosePicture)
        let takePictureAction = UIAlertAction(title: "Take Picture", style: .default, handler: takePicture)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        // adding to optionmenu and presenting it to board
        optionMenu.addAction(choosePictureAction)
        optionMenu.addAction(takePictureAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    
    // Function for when user chooses image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage
        
        addPictureButton.setImage(chosenImage, for: .normal)
        picker.dismiss(animated: true, completion: nil)
        
        // Most likely store image into a variable to send into database (firebase) when clicked
        // If cancelled, it should set the variable to nil --> dont forget this --> do this in the cancel dismiss animation thing
        
        
    }
    
    
    // Prob need another function for when user takes image instead
    // TODO
    
    
    
 
}

