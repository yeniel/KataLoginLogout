//
//  KataLoginLogoutTests.swift
//  KataLoginLogoutTests
//
//  Created by Yeniel Landestoy on 20/9/18.
//  Copyright © 2018 Yeniel Landestoy. All rights reserved.
//

import XCTest
@testable import KataLoginLogout

class KataLoginLogoutTests: XCTestCase {
    
    var kataApp: KataApp!
    var view: MockedView!
    var presenter: Presenter!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_returns_success_if_user_and_password_ok() {
        let kataApp = givenKataApp()
        
        let loginSuccessfully = kataApp.login(username: "admin", password: "admin")
        
        XCTAssert(loginSuccessfully == .success("ok"))
    }
    
    func test_returns_onlyAdmin_if_wrong_user() {
        let kataApp = givenKataApp()
        
        let loginSuccessfully = kataApp.login(username: "a", password: "admin")
        
        XCTAssert(loginSuccessfully == .error(.onlyAdmin))
    }
    
    func test_returns_onlyAdmin_if_wrong_password() {
        let kataApp = givenKataApp()
        
        let loginSucessfully = kataApp.login(username: "admin", password: "a")
        
        XCTAssert(loginSucessfully == .error(.onlyAdmin))
    }
    
    func test_returns_onlyAdmin_if_wrong_user_and_passowrd() {
        let kataApp = givenKataApp()
        
        let loginSucessfully = kataApp.login(username: "a", password: "a")
        
        XCTAssert(loginSucessfully == .error(.onlyAdmin))
    }
    
    func test_logout_ok() {
        let kataApp = givenKataAppWithNowPar()
        
        let logoutSucessfully = kataApp.logout()
        
        XCTAssertTrue(logoutSucessfully)
    }
    
    func test_logout_failed() {
        let kataApp = givenKataAppWithNowImpar()
        
        let logoutSucessfully = kataApp.logout()
        
        XCTAssertFalse(logoutSucessfully)
    }

    func test_show_logout_form_and_hide_login_form_if_login_successfully() {
        givenPresenterWithMockedKataAppWithLoginResult(result: .success("ok"))

        presenter.loginButtonTapped(username: "", password: "")

        XCTAssertTrue(view.hideLoginFormCalled)
        XCTAssertTrue(view.showLogoutFormCalled)
    }
    
    func test_show_login_form_and_hide_logout_form_if_logout_successfully() {
        givenPresenterWithMockedKataAppWithLogoutResult(result: true)
        
        presenter.logoutButtonTapped()
        
        XCTAssertTrue(view.hideLogoutFormCalled)
        XCTAssertTrue(view.showLoginFormCalled)
    }
    
    func test_show_only_admin_error_if_login_returns_only_admin() {
        givenPresenterWithMockedKataAppWithLoginResult(result: .error(.onlyAdmin))
        
        presenter.loginButtonTapped(username: "", password: "")
        
        XCTAssertTrue(view.showErrorMessage == "Only admin")
    }
    
    func test_show_invalid_user_error_if_login_returns_invalid_user() {
        givenPresenterWithMockedKataAppWithLoginResult(result: .error(.invalidUser))
        
        presenter.loginButtonTapped(username: "", password: "")
        
        XCTAssertTrue(view.showErrorMessage == "Invalid User")
    }
    
    func test_show_logout_error_if_logout_fails() {
        givenPresenterWithMockedKataAppWithLogoutResult(result: false)
        
        presenter.logoutButtonTapped()
        
        XCTAssertTrue(view.showErrorMessage == "Logout failed")
    }
    
    // MARK: Private methods
    
    private func givenKataApp() -> KataApp {
        return KataApp(clock: Clock())
    }
    
    private func givenKataAppWithNowPar() -> KataApp {
        let mockedClock = MockedClock()
        
        mockedClock.mockedNow = Date(timeIntervalSince1970: 2)
        
        let kataApp = KataApp(clock: mockedClock)
        
        return kataApp
    }
    
    private func givenKataAppWithNowImpar() -> KataApp {
        let mockedClock = MockedClock()
        
        mockedClock.mockedNow = Date(timeIntervalSince1970: 1)
        
        let kataApp = KataApp(clock: mockedClock)
        
        return kataApp
    }
    
    private func givenPresenterWithMockedKataAppWithLoginResult(result: KataApp.Result)
    {
        kataApp = MockedKataApp()
        view = MockedView()
        presenter = Presenter(ui: view, kataApp: kataApp)
        
        (kataApp as? MockedKataApp)?.mockedLoginResult = result
    }
    
    private func givenPresenterWithMockedKataAppWithLogoutResult(result: Bool) {
        kataApp = MockedKataApp()
        view = MockedView()
        presenter = Presenter(ui: view, kataApp: kataApp)
        
        (kataApp as? MockedKataApp)?.mockedLogoutResult = result
    }
    
}

class MockedClock: Clock {
    var mockedNow: Date = Date()
    
    override var now: Date {
        return mockedNow
    }
}

class MockedKataApp: KataApp {
    var mockedLoginResult: Result!
    var mockedLogoutResult: Bool!
    
    init() {
        super.init(clock: Clock())
    }
    
    override func login(username: String, password: String) -> KataApp.Result {
        return mockedLoginResult
    }
    
    override func logout() -> Bool {
        return mockedLogoutResult
    }
}

class MockedView: View {
    var showErrorMessage: String?
    var showLoginFormCalled = false
    var hideLoginFormCalled = false
    var showLogoutFormCalled = false
    var hideLogoutFormCalled = false
    
    func showError(message: String) {
        showErrorMessage = message
    }
    
    func showLoginForm() {
        showLoginFormCalled = true
    }
    
    func hideLoginForm() {
        hideLoginFormCalled = true
    }
    
    func showLogoutForm() {
        showLogoutFormCalled = true
    }
    
    func hideLogoutForm() {
        hideLogoutFormCalled = true
    }
    
    
}
