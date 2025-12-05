//
//  RegistrationViewController.swift
//  Login_Registration
//
//  Created by Rayimbek Jigitekov on 05.12.2025.
//

import UIKit

protocol RegistrationDelegate: AnyObject {
    func didRegisterNewUser(user: User)
}

class RegistrationViewController: UIViewController {
    
    weak var delegate: RegistrationDelegate?
    
    @IBOutlet weak var filledFullNameLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var filledEmailLabel: UILabel!
    @IBOutlet weak var filledPhoneNumberLabel: UILabel!
    @IBOutlet weak var filledConfirmedPasswordLabel: UILabel!
    @IBOutlet weak var filledPasswordLabel: UILabel!
    @IBOutlet weak var filledUsernameLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registrationButtonAction(_ sender: Any) {
        guard let userName = userNameTextField.text, !userName.isEmpty,
              let fullName = fullNameTextField.text, !fullName.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmedPassword = confirmPasswordTextField.text, !confirmedPassword.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let phoneText = phoneTextField.text, !phoneText.isEmpty, let phone = Int(phoneText)
        else {return}
        
        filledUsernameLabel.text="✅"
        filledFullNameLabel.text="✅"
        filledPasswordLabel.text="✅"
        filledEmailLabel.text="✅"
        filledPhoneNumberLabel.text="✅"
        
        if password == confirmedPassword {
            filledPasswordLabel.text="✅"
            filledConfirmedPasswordLabel.text="✅"
        } else {
            filledConfirmedPasswordLabel.text="❌"
            filledPasswordLabel.text="❌"
        }
        
        let newUser = User(
            userName: userName,
            password: password,
            fullName: fullName,
            email: email,
            phone: phone
        )
        
        delegate?.didRegisterNewUser(user: newUser)
        let delayInSeconds = 2.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
