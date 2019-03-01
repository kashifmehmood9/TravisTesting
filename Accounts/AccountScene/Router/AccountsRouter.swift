//
//  AccountsRouter.swift
//  Accounts
//
//  Created by Kashif Mehmood on 19/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import UIKit

@objc protocol AccountRoutingLogicProtocol {
    func routeToNextView()
}

protocol AccountDataPassing {
    var dataStore: AccountDataStoreProtocol? { get }
}

class AccountsRouter: AccountDataPassing,AccountRoutingLogicProtocol {
    var dataStore: AccountDataStoreProtocol?
    var viewController:AccountsViewController?
    
    //instantiate the view controller based on the instructions from the Presenter
    func routeToNextView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            _ = destinationVC.view
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetails(source: dataStore!, destination: &destinationDS)
            navigateToDetails(source: viewController!, destination: destinationVC)
        }
    }
    //pass data using function to the destination view controller
    func passDataToDetails(source: AccountDataStoreProtocol, destination: inout DetailsDataStoreProtocol) {
        destination.isTransactionSuccessful = source.isTransactionSucessful
    }
// navigate to the destination view conroller
    func navigateToDetails(source: AccountsViewController, destination: DetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    
}
