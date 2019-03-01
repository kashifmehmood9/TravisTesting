//
//  DetailViewController.swift
//  Accounts
//
//  Created by Kashif Mehmood on 19/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import UIKit

protocol DetailsDisplayLogicProtocol:class {
    func displaySomeWork(viewModel: Details.ViewModel)
}
class DetailViewController: UIViewController,DetailsDisplayLogicProtocol,DetailsDataStoreProtocol {
    
    var isTransactionSuccessful: Bool?

   
    
    @IBOutlet weak var messageLabel: UILabel!
    var router:(DetailsDataPassingProtocol & DetailsRouter)?
    var interactor:DetailsBusinessLogicProtocol?

    //MARK: Object Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupUI()
      
      
    }
    
    fileprivate func setupUI() {
        self.messageLabel.text = "Success"
    }
    
    
    func displaySomeWork(viewModel: Details.ViewModel) {
        
        //display the model data to the user
    
    }
//setup components
    func setup() {
        let viewcontroller = self
        let interactor = DetailSceneInteractor()
        let presenter = DetailsScenePresenter()
        let router = DetailsRouter()
        viewcontroller.interactor = interactor
        viewcontroller.router = router
        interactor.presenter = presenter
        presenter.viewController = viewcontroller
        router.viewController = viewcontroller
        router.dataStore = interactor
    }
}
