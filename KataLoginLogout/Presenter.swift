//
//  Presenter.swift
//  KataLoginLogout
//
//  Created by Yeniel Landestoy on 20/9/18.
//  Copyright © 2018 Yeniel Landestoy. All rights reserved.
//

import Foundation
import PromiseKit

class Presenter {
    
    let ui: View
    let kataApp: KataApp
    
    init(ui: View, kataApp: KataApp) {
        self.ui = ui
        self.kataApp = kataApp
    }
    
    func loginButtonTapped(username: String, password: String) {
        _ = kataApp.login(username: username, password: password).done { loginResult -> Void in
            
            if loginResult == .success("ok") {
                self.ui.hideLoginForm()
                self.ui.showLogoutForm()
            } else if loginResult == .error(.onlyAdmin) {
                self.ui.showError(message: "Only admin")
            } else if loginResult == .error(.invalidUser) {
                self.ui.showError(message: "Invalid User")
            } else {
                self.ui.showError(message: "Unknown error")
            }
            
        }
        
    }
    
    func logoutButtonTapped() {
        let logoutResult = kataApp.logout()
        
        if logoutResult {
            ui.hideLogoutForm()
            ui.showLoginForm()
        } else {
            ui.showError(message: "Logout failed")
        }
    }
    
}

protocol View {
    func showError(message: String)
    func showLoginForm()
    func hideLoginForm()
    func showLogoutForm()
    func hideLogoutForm()
}
