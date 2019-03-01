//
//  AccountsUITests.swift
//  AccountsUITests
//
//  Created by Kashif Mehmood on 20/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import XCTest

class AccountsUITests: XCTestCase {

    let app = XCUIApplication()
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        
        app.terminate()
    }

    //Check for the existence of the button and textfield
    func testMainViewElementsForExistence()
    {
        let textField = app.textFields["AmountTextField"]
        XCTContext.runActivity(named: "There should be a  \(textField)") { _ in
            XCTAssertTrue(textField.exists)
        }
        
        let deductButton = app.buttons["DeductButton"]
        XCTContext.runActivity(named: "There should be a  \(deductButton)") { _ in
            XCTAssertTrue(deductButton.exists)
        }
    }
    //Look for button and textfield and interact with them
    func testUIElemetsForExistenceAndTitle() {
      
       
       let textField = app.textFields["AmountTextField"]
        
        XCTAssertEqual(textField.placeholderValue, "Enter Deduction Amount")
        textField.tap()
        textField.typeText("100")
        
        
        let deductButton = app.buttons["DeductButton"]
        XCTAssertEqual(deductButton.label, "Deduct")
        deductButton.tap()
        
        let detailsView = app.otherElements["DetailView"]
        let detailsSuccessShown = detailsView.waitForExistence(timeout: 5)
        
        //if the next view is shown or not
        XCTAssert(detailsSuccessShown)
        
    }
    
    func testForAlertPoppingUpWhenTextFieldIsEmpty()
    {
        
        let deductButton = app.buttons["DeductButton"]
        deductButton.tap()
        XCTAssert(app.alerts["Field Error"].exists)
        
        
    }

}
