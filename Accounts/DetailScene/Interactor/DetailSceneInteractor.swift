//
//  DetailSceneInteractor.swift
//  Accounts
//
//  Created by Kashif Mehmood on 19/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import UIKit

protocol DetailsBusinessLogicProtocol :class {
    func doSomeDetailsFunctionality(request: Details.Request)
}

protocol DetailsDataStoreProtocol {
    //declare some variables which can be used to pass data to next view controllers
    var isTransactionSuccessful:Bool? {get set}
}
class DetailSceneInteractor: DetailsDataStoreProtocol,DetailsBusinessLogicProtocol {
    var isTransactionSuccessful: Bool?
    

     var presenter:DetailsPresentationBusinessLogicProtocol?
    
    func doSomeDetailsFunctionality(request: Details.Request) {
        
        //initiate the worker and assign him some work after completion call the presenter to present the work 
        
    presenter?.presentSomeWork(response: Details.Response())
    }
    

}
