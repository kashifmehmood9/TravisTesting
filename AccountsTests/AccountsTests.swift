//
//  AccountsTests.swift
//  AccountsTests
//
//  Created by Kashif Mehmood on 19/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import XCTest
import Mockingjay
@testable import DebitAccount
import Alamofire
class AccountsTests: XCTestCase {
    
    override func setUp() {
   
    }
    
    override func tearDown() {
        
    }
    
    func testAccountsViewControllerUIElements()
    {
        guard let accountsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountsViewController") as? AccountsViewController
            else {
                XCTFail("Instantiated view controller is not accoutns view controller")
                return
        }
        //load view of view controller without calling viewdidload
        _ = accountsViewController.view
        
        
        //check for the nil of outlets and variables.
        XCTAssertNotNil(accountsViewController.interactor)
        XCTAssertNotNil(accountsViewController.router)
        XCTAssertNotNil(accountsViewController.deductionAmountTextField)
        XCTAssertNotNil(accountsViewController.deductAmountButton)
        
        XCTAssertEqual(accountsViewController.deductionAmountTextField.text, "")
        XCTAssertEqual(accountsViewController.deductAmountButton.currentTitle, "Deduct")
        XCTAssertEqual(accountsViewController.deductionAmountTextField.placeholder, "Enter Deduction Amount")
        
    }
    
    func testURLStringInAcountsWorker()
        
    {
        let accountViewController = AccountsViewController()
        accountViewController.setup()
        
        guard let interactor = accountViewController.interactor as? AccountInteractor
            else {
                XCTFail("Couldnot cast to account interactor")
                return
        }
        interactor.worker = AccountWorker()
        XCTAssertEqual(interactor.worker?.urlString, "https://jsonplaceholder.typicode.com/todos/4")
        
        
    }
    //This test depends on the internet speed and timeout of 10 seconds after which it will fail.
    func testTransactionSuccessByUsingAccountInteractor()
    {
        
        let accountsViewController =  AccountsViewController()
        
        //setup  VIPER variables.
        accountsViewController.setup()
        
        let promise = expectation(description: "API Call should be completed without time out")
        let interactor = accountsViewController.interactor as? AccountInteractor
        
        //let the interactor to call the api and then check for transaction success
        interactor?.deductAmountFromAccount(request: Account.Request(currentBalance: 1000, amountToBeDeducted: 100))
        
        //Wait for the objects to pass around the data and then check
        let result = XCTWaiter.wait(for: [promise], timeout: 5)
        
        if result == XCTWaiter.Result.timedOut {
            if (interactor?.isTransactionSucessful)!
            {
                promise.fulfill()
            }
            else
            {
                XCTAssert(interactor?.isTransactionSucessful ?? false)
            }
        } else {
            XCTFail("Delay interrupted")
        }
        
    }
    //Ideally some of the code inside this method should be in setup but then it would stub all response to the same URL
    func testAPICallUsingStubs()
    {
        
        //Mock responses
        let serverErrorStub = http(500, headers: nil, download: nil)
        let notFoundStub = http(404, headers: nil, download: nil)
        
        //passing and failing of this test depends on this stub response
        let responseStub = ["completed":true]
        
        //Adding stubs
        stub(uri("https://jsonplaceholder.typicode.com/todos/4"), json(responseStub))
        stub(uri("http://abc.abc.com/"),serverErrorStub )
        stub(uri("http://abc.abc.com/"),notFoundStub )
        
        let promise = expectation(description: "expectation based on the repsonse stub")
        //Call the API with stubbed response
        request("https://jsonplaceholder.typicode.com/todos/4").responseJSON { (response) in
                        print(response)
            
            if let response = response.result.value as? [String:Any]
            {
                let transcationCompeleted =  response["completed"] as! Bool
                
                if transcationCompeleted
                {
                    promise.fulfill()
                    XCTAssert(transcationCompeleted,"transaction is complete")
                }
                else
                {
                    promise.fulfill()
                    XCTAssert(transcationCompeleted,"transaction is not completed")
                }
            }
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
