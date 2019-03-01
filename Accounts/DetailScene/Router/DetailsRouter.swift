//
//  DetailsRouter.swift
//  Accounts
//
//  Created by Kashif Mehmood on 19/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import UIKit

protocol DetailsRoutingLogicProtocol {
    func routeToSomeView()
}

protocol DetailsDataPassingProtocol {
    var dataStore: DetailsDataStoreProtocol? {get}
}

class DetailsRouter: DetailsRoutingLogicProtocol, DetailsDataPassingProtocol {
    var dataStore: DetailsDataStoreProtocol?
    weak var viewController: DetailViewController?
    
    func routeToSomeView() {
        //Write code to navigate to other screens
    }
}
