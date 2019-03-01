//
//  DetailsTests.swift
//  AccountsTests
//
//  Created by Kashif Mehmood on 20/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import XCTest
@testable import DebitAccount
class DetailsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
//test the outlets and variables of the details view controller
    func testDetailsScene()
    {
        let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        _ = detailsViewController?.view
        
        XCTAssertNotNil(detailsViewController?.messageLabel)
        XCTAssertEqual(detailsViewController?.messageLabel.text, "Success")
        XCTAssertNotNil(detailsViewController?.router)
        XCTAssertNotNil(detailsViewController?.interactor)
    }
    //this test will always fail because we havent followed the proper procedure for making the transcation successful
    func testForSuccessOfTransaction()
    {
        let detailsViewController = DetailViewController()
        
        XCTAssertTrue(detailsViewController.isTransactionSuccessful ?? true)
    }

}
