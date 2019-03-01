//
//  AccountsInteractor.swift
//  Accounts
//
//  Created by Kashif Mehmood on 19/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import UIKit

protocol AccountBusinessLogicProtocol :class {
    func deductAmountFromAccount(request: Account.Request)
}

protocol AccountDataStoreProtocol {
    //To store value which can be passed to other screens.
    var isTransactionSucessful: Bool? {get set}
}

class AccountInteractor:AccountBusinessLogicProtocol,AccountDataStoreProtocol
{
    var worker:AccountWorker?
    var isTransactionSucessful: Bool?
    var presenter:BalancePresentationBusinessLogicProtocol?
    
    //delegate the work to the worker to actually call the API and parse the response using Alamofire
    func deductAmountFromAccount(request: Account.Request) {
        self.worker = AccountWorker()
        
        self.worker?.deductAmountFromAccount(deductionAmount: request.amountToBeDeducted ?? 0, completion: { (response, error) in
            
            if error != nil
            {
                print("An error occured ",error ?? "")
                return
                
            }
            if let responseValue = response.result.value as? [String:Any]
            {
                if let isTransactionSucessful = responseValue["completed"] as? Bool
                {
                    self.isTransactionSucessful = isTransactionSucessful
                }
            }
            
            //Call to presenter to tell view controller to display
            self.presenter?.presentAccountBalance(response: Account.Response(isTransactionSucessful: self.isTransactionSucessful))
            
        })
    }
}

