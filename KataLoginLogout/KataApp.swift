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
    
    enum Result: Equatable {
        case success(String)
        case error(LoginErrors)
        
        public static func ==(lhs: Result, rhs:Result) -> Bool {
            
            switch (lhs,rhs) {
            case (.error(let loginErrorA), .error(let logintErrorB)):
                return loginErrorA == logintErrorB
            case (.success(let messageA), .success(let messageB)):
                return messageA == messageB
            default:
                return false
            }
            
        }
    }
    
    enum LoginErrors {
        case onlyAdmin
        case invalidUser
    }
    
    let clock: Clock!
    
    init(clock: Clock) {
        self.clock = clock
    }
    
    func login(username: String, password: String) -> Result {
        var loginSuccessfully: Result
        let charset = CharacterSet(charactersIn: ",.;")
        
        if username.rangeOfCharacter(from: charset) != nil {
            loginSuccessfully = Result.error(.invalidUser)
        } else {
            if username == "admin"
                && password == "admin"
            {
                loginSuccessfully = Result.success("ok")
            } else {
                loginSuccessfully = Result.error(.onlyAdmin)
            }
        }
        
        return loginSuccessfully
    }
    
    func logout() -> Bool {
        return Int(clock.now.timeIntervalSince1970) % 2 == 0
    }
    
}
