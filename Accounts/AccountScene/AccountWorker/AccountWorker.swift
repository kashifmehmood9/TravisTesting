//
//  AccountWorker.swift
//  Accounts
//
//  Created by Kashif Mehmood on 19/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import UIKit
import Alamofire
class AccountWorker {

    typealias WorkCompletionBlock = (_ response : DataResponse<Any>, _ error : Error?) -> Void
    let urlString = "https://jsonplaceholder.typicode.com/todos/4"
    
    func deductAmountFromAccount(deductionAmount:Double, completion:@escaping(WorkCompletionBlock))
    {
        
        //Send request to the specified URL using Alamofire
        request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        
            
            print(response.result.value ?? "Error")
            //pass to the compeltion handler
            completion(response,response.result.error)
        }
        
        
    }
    
}
