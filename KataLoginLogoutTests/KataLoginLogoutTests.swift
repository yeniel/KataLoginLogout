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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_login_ok() {
        let kataApp = givenKataApp()
        let loginSuccessfully = kataApp.login(username: "admin", password: "admin")
        
        XCTAssertTrue(loginSuccessfully)
    }
    
    func test_wrong_user() {
        let kataApp = givenKataApp()
        let loginSuccessfully = kataApp.login(username: "a", password: "admin")
        
        XCTAssertFalse(loginSuccessfully)
    }
    
    func test_wrong_password() {
        let kataApp = givenKataApp()
        let loginSucessfully = kataApp.login(username: "admin", password: "a")
        
        XCTAssertFalse(loginSucessfully)
    }
    
    func test_wrong_user_and_passowrd() {
        let kataApp = givenKataApp()
        let loginSucessfully = kataApp.login(username: "a", password: "a")
        
        XCTAssertFalse(loginSucessfully)
    }
    
    func test_logout_ok() {
        let mockedClock = MockedClock()
        
        mockedClock.mockedNow = Date(timeIntervalSince1970: 2)
        
        let kataApp = givenKataAppWithClock(clock: mockedClock)
        let logoutSucessfully = kataApp.logout()
        
        XCTAssertTrue(logoutSucessfully)
    }
    
    func test_logout_failed() {
        let mockedClock = MockedClock()
        
        mockedClock.mockedNow = Date(timeIntervalSince1970: 1)
        
        let kataApp = givenKataAppWithClock(clock: mockedClock)
        let logoutSucessfully = kataApp.logout()
        
        XCTAssertFalse(logoutSucessfully)
    }
    
    private func givenKataApp() -> KataApp {
        return KataApp(clock: Clock())
    }
    
    private func givenKataAppWithClock(clock: Clock) -> KataApp {
        let kataApp = KataApp(clock: clock)
        
        return kataApp
    }
    
}

class MockedClock: Clock {
    var mockedNow: Date = Date()
    
    override var now: Date {
        return mockedNow
    }
}
