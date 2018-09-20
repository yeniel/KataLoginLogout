//
//  ViewController.swift
//  KataLoginLogout
//
//  Created by Yeniel Landestoy on 20/9/18.
//  Copyright © 2018 Yeniel Landestoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userTextEdit: UITextField!
    @IBOutlet weak var passwordTextEdit: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonTap(_ sender: Any) {
        let clock = Clock()
        let kataApp = KataApp(clock: clock)
        var title = ""
        
        if loginButton.title(for: UIControlState.normal) == "Login" {
            if kataApp.login(username: userTextEdit.text!, password: passwordTextEdit.text!)
            {
                title = "Login OK"
                
                userTextEdit.isHidden = true
                passwordTextEdit.isHidden = true
                loginButton.setTitle("Logout", for: UIControlState.normal)
            } else {
                title = "Login failed"
            }
            
            let alert = UIAlertController(title: title,
                                          message: "",
                                          preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else if loginButton.title(for: UIControlState.normal) == "Logout" {
            if kataApp.logout() {
                userTextEdit.isHidden = true
                passwordTextEdit.isHidden = true
                loginButton.setTitle("Logout", for: UIControlState.normal)
            }
        }
    }
    
}



