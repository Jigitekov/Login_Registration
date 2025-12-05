//
//  ViewController.swift
//  Login_Registration
//
//  Created by Rayimbek Jigitekov on 05.12.2025.
//

import UIKit

struct User: Codable {
    let userName: String
    let password: String
    let fullName: String
    let email: String
    let phone: Int
}


class ViewController: UIViewController, UITextFieldDelegate, RegistrationDelegate {

    var users: [User] = [
        User(userName: "Raiymbek", password: "qwerty", fullName: "Raiymbek Jigitekov", email: "jrayimbek04@mgail.com", phone: 8777777777),
        User(userName: "Admin", password: "admin", fullName: "AdminAdmin", email: "admin@admin", phone: 8777545563)
    ]
    
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var registrationbutton: UIButton!
    @IBOutlet weak var labelWelcome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        userNameTextField.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            userNameTextField.text = ""
            passwordTextField.text = ""
            
            labelMessage.text = ""
            labelWelcome.text = ""
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
                passwordTextField.becomeFirstResponder()
            } else if textField == passwordTextField {
                textField.resignFirstResponder()
                loginAction(self)
            }
        return false
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let userName = userNameTextField.text, !userName.isEmpty else {
            labelMessage.text = "Please enter your username"
            labelMessage.textColor = .red
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            labelMessage.text = "Please enter your password"
            labelMessage.textColor = .red
            return
        }
        
        if let user = users.first (where:{
            $0.userName.lowercased() == userName.lowercased() && $0.password == password
        }) {
            labelWelcome.text = "Welcome \(user.fullName)"
            labelWelcome.textColor = .green
            let delayInSeconds = 1.0
            DispatchQueue.main.asyncAfter (deadline: .now() + delayInSeconds) {
                self.performSegue(withIdentifier:"loginSegue", sender: sender)
            }
        } else {
            labelMessage.text = "Invalid username or password"
            labelMessage.textColor = .red
            shakeAnimation()
        }
        self.view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
                if let username = userNameTextField.text,
                   let password = passwordTextField.text,
                   let loggedInUser = users.first(where: { $0.userName.lowercased() == username.lowercased() && $0.password == password }),
                   let homeVC = segue.destination as? HomeViewController
                {
                    homeVC.fullName = loggedInUser.fullName
                    homeVC.userName = loggedInUser.userName
                    homeVC.password = loggedInUser.password
                    homeVC.email = loggedInUser.email
                    homeVC.phone = loggedInUser.phone
                }
            }
        if segue.identifier == "showRegistration" {
            if let registrationVC = segue.destination as? RegistrationViewController {
                registrationVC.delegate = self
            }
        }
        }
    
    func shakeAnimation() {
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
            animation.duration = 0.6
            animation.values = [-10, 10, -10, 10, -5, 5, -2.5, 2.5, 0]
            passwordTextField.layer.add(animation, forKey: "shake")
        }
    
    func didRegisterNewUser (user: User) {
        self.users.append(user)
        
        print(" Новый пользователь \(user.userName) добавлен. Всего пользователей: \(self.users.count)")
    }
}
