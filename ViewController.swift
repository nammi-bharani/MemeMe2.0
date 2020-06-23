//
//  ViewController.swift
//  MemeMe
//
//  Created by Bharani Nammi on 3/25/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import UIKit

var memeObject: Meme!

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var ImagePickerView: UIImageView!
    
    
    @IBOutlet weak var topTextField: UITextField!
    
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var camerAButton: UIBarButtonItem!
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black ,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3.5
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
       // topTextField.textAlignment = .center
       // bottomTextField.textAlignment = .center
        
        
       // topTextField.text = "TOP"
       // bottomTextField.text = "BOTTOM"
        
        
        
        
        //topTextField.defaultTextAttributes = memeTextAttributes
       // bottomTextField.defaultTextAttributes = memeTextAttributes
        
        setupTextFieldStyle(toTextField: topTextField, defaultText: "TOP")
        setupTextFieldStyle(toTextField: bottomTextField, defaultText: "BOTTOM")
        
    }
    
    func setupTextFieldStyle(toTextField textField: UITextField, defaultText: String) {
        
        textField.textAlignment = .center
        
        textField.text = defaultText
        
        textField.defaultTextAttributes = memeTextAttributes
        
        textField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        camerAButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        super.viewWillAppear(animated)
         subscribeToKeyboardNotifications()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
//    @IBOutlet weak var cameraButton: UIButton!
//    
//    override func viewWillAppear(_ animated: Bool) {
//        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
//    }

    @IBAction func PickImageAlbum(_ sender: Any) {
        
        //let imagePicker = UIImagePickerController()
        //imagePicker.delegate = self
        //imagePicker.sourceType = .photoLibrary
        //present(imagePicker, animated: true, completion: nil)
        
        pickAnImage(from: .photoLibrary)
    }
    
    @IBAction func PickImageCamera(_ sender: Any) {
        
       // let imagePicker = UIImagePickerController()
        //imagePicker.delegate = self
        //imagePicker.sourceType = .camera
        //present(imagePicker, animated: true, completion: nil)
        
        pickAnImage(from: .camera)
    }
    
    
    func pickAnImage(from source: UIImagePickerController.SourceType) {
        // TODO:- code to pick an image from source
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print("executes did finish picking")
        
        if let chosenImage = info[.originalImage] as? UIImage {
            ImagePickerView.contentMode = .scaleAspectFill
            ImagePickerView.image = chosenImage

        } else{
            print("Something went wrong")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
        print("executes did cancel")
    }
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if bottomTextField.isEditing {
             view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
        
        view.frame.origin.y = 0
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    func generateMemedImage() -> UIImage {

        // TODO: Hide toolbar and navbar
        
        self.toolBar.isHidden = true
        
        self.cancelButton.isHidden = true
        
        self.shareButton.isHidden = true
        
        self.navigationBar.isHidden = true
        
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // TODO: Show toolbar and navbar

        self.toolBar.isHidden = false
        
        self.cancelButton.isHidden = false
        
        self.shareButton.isHidden = false
        
        self.navigationBar.isHidden = false
        
        return memedImage
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
    
        textField.resignFirstResponder()
        return true
    }

    
    func save() {
        // Create The Meme
        let memedImage = generateMemedImage()
        let meme = Meme(top: topTextField.text!, bottom: bottomTextField.text!, image: ImagePickerView.image, memedImage:memedImage)
        //TODO: Add to memes array in AppDelegate
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
           let memedImage = generateMemedImage()
           let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
           activityController.completionWithItemsHandler = { activity, success, items, error in
               self.save()
               self.dismiss(animated: true, completion: nil)
           }
           
           present(activityController, animated: true, completion: nil)
           
       }
       @IBAction func cancelButtonAction(_ sender: Any) {
           //self.dismissViewControllerAnimated(true, completion: nil)
           topTextField.text = "TOP"
           bottomTextField.text = "BOTTOM"
           self.ImagePickerView.image = nil
       }
    
    
    
}

