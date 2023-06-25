//
//  Unit_test_SampleUITests.swift
//  Unit test SampleUITests
//
//  Created by 문상우 on 2023/06/23.
//

import XCTest

final class Unit_test_SampleUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var emailTextField: XCUIElement!
    private var passwordTextField: XCUIElement!
    private var repeatPasswordTextField: XCUIElement!
    private var signUpButton: XCUIElement!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        
        emailTextField = app.textFields["emailTextField"]
        passwordTextField = app.textFields["passwordTextField"]
        repeatPasswordTextField = app.textFields["repeatPasswordTextField"]
        signUpButton = app.buttons["signUpButton"]
        
        emailTextField.tap()
        emailTextField.typeText("fomagran6@naver.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("12345678")
        
        repeatPasswordTextField.tap()
        repeatPasswordTextField.typeText("123456")
        
        signUpButton.tap()
        
        //Assert
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1),"잘못된 정보를 입력하면 경고창이 떠야하는데 안떴어요")
    }
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}
