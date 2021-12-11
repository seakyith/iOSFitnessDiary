//
//  LogInViewController.swift
//  finalProject
//
//  Created by Seak Yith on 11/26/21.
//

import UIKit
import FirebaseAuth




class LogInViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var errorMessage: UILabel!
    // style button
    func stylebutton(button : UIButton, title : String){
        button.configuration = .gray()
        button.configuration?.baseForegroundColor = .systemPink
        button.configuration?.title = title
        button.configuration?.image = UIImage(systemName: "lock.open")
        button.configuration?.imagePadding = 10
        //logInButton.configuration?.cornerStyle = .capsule
        
    }
    
    // showing error if user failed to log in
    func showError(_ message: String)
    {
        errorMessage.text = message
        errorMessage.alpha = 1
    }
    // go to home screen when log in success
    func TransitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboaed.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    // validate password and email fields
    func validateFields() -> String? {
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill all required field"
        }
        else{
            let emailAddress1 = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password1 = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //sign in user
            Auth.auth().signIn(withEmail: emailAddress1, password: password1) {
                (result, error) in
                if error != nil {
                    // show error message
                    self.showError("Incorrect Email or password")
                }
                else{
                    self.TransitionToHome()
                }
            
        
        }
        return nil
    }
}
    
    
    @IBAction func signIn(_ sender: UIButton) {
        let error = validateFields()
        if error != nil
        {
            self.showError("Failed")
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        errorMessage.alpha = 0
        
        //style background and buttons
        self.stylebutton(button: signInButton, title: "Sign In")
        view.addBackground(imageName: "image1.jpg")
        view.addBackground(imageName: "image1.jpg", contentMode: .scaleAspectFit)
        email.layer.masksToBounds = true
        email.layer.borderColor = UIColor.systemPink.cgColor
        email.layer.borderWidth = 0.3
    }


}
