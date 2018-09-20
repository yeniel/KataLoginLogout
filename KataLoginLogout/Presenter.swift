//
//  Presenter.swift
//  KataLoginLogout
//
//  Created by Yeniel Landestoy on 20/9/18.
//  Copyright © 2018 Yeniel Landestoy. All rights reserved.
//

import Foundation

class Presenter {
    
    let ui: View
    let kataApp: KataApp
    
    init(ui: View, kataApp: KataApp) {
        self.ui = ui
        self.kataApp = kataApp
    }
    
    func loginButtonTapped(username: String, password: String) {
        let loginResult = kataApp.login(username: username, password: password)
        
        if loginResult == .success("ok") {
            ui.hideLoginForm()
            ui.showLogoutForm()
        } else if loginResult == .error(.onlyAdmin) {
            ui.showError(message: "Only admin")
        } else if loginResult == .error(.invalidUser) {
            ui.showError(message: "Invalid User")
        } else {
            ui.showError(message: "Unknown error")
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
