//
//  HomeViewController.swift
//  Login_Registration
//
//  Created by Rayimbek Jigitekov on 05.12.2025.
//

import UIKit

class HomeViewController: UIViewController {

    var fullName: String?
    var userName: String?
    var password: String?
    var email: String?
    var phone: Int?
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var labelWelcome: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelWelcome.text = "Welcome, \(fullName ?? "User")"
        infoTextView.text = ""
        saveButton.isHidden = true
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func infoByttonAction(_ sender: Any) {
        let userInfo = """
            Полное имя: \(fullName ?? "Не указано")
            Имя пользователя: \(userName ?? "Не указано")
            Пароль: \(password ?? "Скрыт")
            Email: \(email ?? "Не указан")
            Телефон: \(phone?.description ?? "Не указан")
            """
        infoTextView.text = userInfo
        saveButton.isHidden = false
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
    }
}
