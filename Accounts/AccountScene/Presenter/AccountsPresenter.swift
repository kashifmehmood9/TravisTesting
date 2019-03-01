//
//  AccountsPresenter.swift
//  Accounts
//
//  Created by Kashif Mehmood on 19/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import Foundation

protocol BalancePresentationBusinessLogicProtocol{
    func presentAccountBalance(response: Account.Response)
}


class AccountsPresenter: BalancePresentationBusinessLogicProtocol {
    
    weak var viewController:AccountDisplayLogicProtocol?
    func presentAccountBalance(response: Account.Response) {
        let viewModel = Account.ViewModel(isTransactionSucessful:response.isTransactionSucessful)
        
        //display the view model data to the user
        viewController?.displayAccountBalance(viewModel: viewModel)
        
    }
    

}
