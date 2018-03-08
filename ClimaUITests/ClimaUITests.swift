//
//  ClimaUITests.swift
//  ClimaUITests
//
//  Created by Srijan Raj on 07/03/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import XCTest
//@testable import MockServer
@testable import Wiremock

class ClimaUITests: XCTestCase {
    
    var app : XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
        guard let app = app else {
            XCTFail("must be able to create an XCUIApplication()")
            return
        }
        
        sleep(5)
        let button = app.buttons["Change City Button"]
            waitFor(button)
        
        button.tap()
        
        let cityField = app.textFields["City Name Text Field"]
        waitFor(cityField)
        
        cityField.clearAndEnterText(text : "Delhi")
        app.typeText("\r")
        
        let checkWeather = app.buttons["Get Weather Button"]
        waitFor(checkWeather)
        checkWeather.tap()
        
        sleep(5)
 
    }
    
    func waitFor(_ element:XCUIElement, timeout: TimeInterval = 60)
    {
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    
    
    
}

extension XCUIApplication {
    func setUpAndLaunch() {
        launchEnvironment = ["DISABLE_ANIMATIONS": "1"]
        launch()
    }
    
}
extension XCUIElement {
    func clearAndEnterText(text:String)
    {
        self.tap()
        if (self.buttons["Clear text"].exists) {
            self.buttons["Clear text"].tap()
        }
        
        self.typeText(text)
    }
}
