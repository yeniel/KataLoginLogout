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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonTap(_ sender: Any) {
        if userTextEdit.text == "admin"
            && passwordTextEdit.text == "admin"
        {
            let alert = UIAlertController(title: "Login Successfully",
                                          message: "",
                                          preferredStyle: .alert)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

