//
//  ViewController.swift
//  KataLoginLogout
//
//  Created by Yeniel Landestoy on 20/9/18.
//  Copyright © 2018 Yeniel Landestoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, View {

    @IBOutlet weak var userTextEdit: UITextField!
    @IBOutlet weak var passwordTextEdit: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    var presenter: Presenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Presenter(ui: self, kataApp: KataApp(clock: Clock()))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loginButtonTap(_ sender: Any) {
        presenter.loginButtonTapped(username: userTextEdit.text ?? "",
                                    password: passwordTextEdit.text ?? "")
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        presenter.logoutButtonTapped()
    }
    
    func showLoginForm() {
        userTextEdit.isHidden = false
        passwordTextEdit.isHidden = false
        loginButton.isHidden = false
    }
    
    func hideLoginForm() {
        userTextEdit.isHidden = true
        passwordTextEdit.isHidden = true
        loginButton.isHidden = true
    }
    
    func showLogoutForm() {
        logoutButton.isHidden = false
    }
    
    func hideLogoutForm() {
        logoutButton.isHidden = true
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok",
                                     style: UIAlertActionStyle.default,
                                     handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}



