//
//  DetailsScenePresenter.swift
//  Accounts
//
//  Created by Kashif Mehmood on 19/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import UIKit

protocol DetailsPresentationBusinessLogicProtocol{
    func presentSomeWork(response: Details.Response)
}
class DetailsScenePresenter: DetailsPresentationBusinessLogicProtocol {
    
    var viewController: DetailsDisplayLogicProtocol?
    
    func presentSomeWork(response: Details.Response) {
        //after response from the presenter, pass the view model to the view comtroller for its displaying to the user. in this case a dummy view model is sent to the view controller
        viewController?.displaySomeWork(viewModel: Details.ViewModel())
    }
    

}
