//
//  UITesting_UITest.swift
//  UITesting_UITests
//
//  Created by Pjot on 22.11.2022.
//

import XCTest

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then

class UITesting_UITest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_UITesting_goButton_shouldNotSignIn () {
        //        Given
        let textFiled = app.textFields["SignUpTextField"]
        
        //        When
        textFiled.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let goButton = app.buttons["SingUpButton"]
        goButton.tap()
        
        let navBar = app.navigationBars["Welcome!!!"]
        
        //        Then
        XCTAssertFalse(navBar.exists)
    }
    
    func test_UITesting_goButton_shouldSignIn () {
        //        Given
        let textFiled = app.textFields["SignUpTextField"]
        
        //        When
        textFiled.tap()
        
        let keyA = app.keys["A"]
        keyA.tap()
        let keyLowerA = app.keys["a"]
        keyLowerA.tap()
        keyLowerA.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let goButton = app.buttons["SingUpButton"]
        goButton.tap()
        
        let navBar = app.navigationBars["Welcome!!!"]
        
        //        Then
        XCTAssertTrue(navBar.exists)
        
    }
    
    func test_SignedHomeView_shouldDisplayAlert () {
        //        Given
        let textFiled = app.textFields["SignUpTextField"]
        
        //        When
        textFiled.tap()
        
        let keyA = app.keys["A"]
        keyA.tap()
        let keyLowerA = app.keys["a"]
        keyLowerA.tap()
        keyLowerA.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let goButton = app.buttons["SingUpButton"]
        goButton.tap()
        
        let navBar = app.navigationBars["Welcome!!!"]
        XCTAssertTrue(navBar.exists)
        
        let alertButton = app.buttons["AlertButton"]
        alertButton.tap()
        
        let alert = app.alerts["WELCOME!!!"]
        
        //        Then
        
        XCTAssertTrue(alert.exists)
        
    }
    
    func test_SignedHomeView_shouldDisplayAndDismissAlert () {
        //        Given
        let textFiled = app.textFields["SignUpTextField"]
        
        //        When
        textFiled.tap()
        
        let keyA = app.keys["A"]
        keyA.tap()
        let keyLowerA = app.keys["a"]
        keyLowerA.tap()
        keyLowerA.tap()
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let goButton = app.buttons["SingUpButton"]
        goButton.tap()
        
        let navBar = app.navigationBars["Welcome!!!"]
        XCTAssertTrue(navBar.exists)
        
        let alertButton = app.buttons["AlertButton"]
        alertButton.tap()
        
        let alert = app.alerts["WELCOME!!!"]
        XCTAssertTrue(alert.exists)
        
        let alertOKButton = alert.buttons["OK"]
        XCTAssertTrue(alertOKButton.exists)
        sleep(1)
        alertOKButton.tap()
        
        //        Then
        
        XCTAssertFalse(alert.exists)
        
        
        
    }
    
}
