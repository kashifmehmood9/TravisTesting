//
//  DetailsScreeenUITests.swift
//  AccountsUITests
//
//  Created by Kashif Mehmood on 20/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import XCTest

class DetailsScreeenUITests: XCTestCase {

    let app = XCUIApplication()
    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("skipEntryViewController")
        app.launch()
    }

    override func tearDown() {
//        app.terminate()
    }
    
    func testIfDetailsViewExists()
    {
        let successLabel = app.otherElements["DetailsView"]
       
        XCTAssertTrue(successLabel.exists)
    }
    
    
}
