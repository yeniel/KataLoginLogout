//
//  KataApp.swift
//  KataLoginLogout
//
//  Created by Yeniel Landestoy on 20/9/18.
//  Copyright © 2018 Yeniel Landestoy. All rights reserved.
//

import Foundation
import UIKit

class KataApp {
    
    let clock: Clock!
    
    init(clock: Clock) {
        self.clock = clock
    }
    
    func login(username: String, password: String) -> Bool {
        var loginSuccessfully: Bool
        
        if username == "admin"
            && password == "admin"
        {
            loginSuccessfully = true
        } else {
            loginSuccessfully = false
        }
        
        return loginSuccessfully
    }
    
    func logout() -> Bool {
        return Int(clock.now.timeIntervalSince1970) % 2 == 0
    }
    
}
