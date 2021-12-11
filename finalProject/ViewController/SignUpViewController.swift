//
//  SignUpViewController.swift
//  finalProject
//
//  Created by Seak Yith on 12/3/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var emailaddress: UITextField!
    @IBOutlet var errorMessage: UILabel!
    @IBOutlet var signUP: UIButton!
    
    
    //button style
    func stylebutton(button : UIButton, title : String){
        button.configuration = .gray()
        button.configuration?.baseForegroundColor = .systemPink
        button.configuration?.title = title
        button.configuration?.image = UIImage(systemName: "lock.open")
        button.configuration?.imagePadding = 10
        //logInButton.configuration?.cornerStyle = .capsule
        
    }
    
    
    // Validate if data is correct, return nil if correct
        func validateFields() -> String? {
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailaddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill all required field"
        }
        else{
            let firstName1 = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName1 = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let emailAddress1 = emailaddress.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password1 = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: emailAddress1, password: password1) { (result, err) in
                //check for error
                if err != nil {
                    //error occured
                    self.showError("Error Creating User, Password need to be 8 characters")
                }
                else{
                    //successfully creating
                    let userDB = Firestore.firestore()
                    userDB.collection("users").addDocument(data: ["firstName": firstName1, "lastName": lastName1, "emailAddress": emailAddress1, "password": password1, "uid" : result!.user.uid]) { (error) in
                        if error != nil {
                            // show error message
                            self.showError("User Data can not enter")
                        }
                    }
                    // To Home Screen
                    self.TransitionToHome()
                    
                    
                }
            }
        }
        // Need password validation
        
        return nil
        
    }
    
    
    @IBAction func signUpButton(_ sender: UIButton) {
        // Validate field
        let error = validateFields()
        if error != nil
        {
            self.showError("Failed")
        }
        
    }
     // show error if sign up mails
    func showError(_ message: String)
    {
        errorMessage.text = message
        errorMessage.alpha = 1
    }
    // if sign up successful,,, go to home screen
    func TransitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboaed.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.alpha = 0
        self.stylebutton(button: signUP, title: "Register")
        // style button and background
        view.addBackground(imageName: "image7.jpg")
        view.addBackground(imageName: "image7.jpg", contentMode: .scaleAspectFit)
        
    }
}
    
    
    
    
    
    
