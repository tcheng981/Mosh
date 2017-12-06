//
//  LoginViewController.swift
//  Custom-App
//
//  Created by Tony Cheng on 11/30/17.
//  Copyright © 2017 Tony Cheng. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userEmail = ""
    var userPassword = ""
    
    @IBAction func logInPressed(_ sender: UIButton) {
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }

        if emailText == "" || passwordText == "" {
            let alertController = UIAlertController(title: "Log In Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "LogInToMain", sender: self)
                } else {
                    let alertController = UIAlertController(title: "Log In Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
//                    DispatchQueue.main.async {
//                        self.present(alertController, animated: true, completion: nil)
//                    }
                }
            }
        }
    }
    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "LogInToSignUp", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundX.jpg")!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if Auth.auth().currentUser != nil {
//            self.performSegue(withIdentifier: "LogInToMain", sender: self)
//        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            if textField.text != nil {
                self.userEmail = textField.text!
            }
        } else {
            if textField.text != nil {
                self.userPassword = textField.text!
            }
        }
    }

}
