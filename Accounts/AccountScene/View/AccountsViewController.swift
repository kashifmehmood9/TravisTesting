//
//  ViewController.swift
//  Accounts
//
//  Created by Kashif Mehmood on 19/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import UIKit

protocol AccountDisplayLogicProtocol : class{
    func displayAccountBalance(viewModel:Account.ViewModel)
}

class AccountsViewController: UIViewController,UITextFieldDelegate,AccountDisplayLogicProtocol {

//    var presenter:BalancePresentationBusinessLogicProtocol?
    var interactor:AccountBusinessLogicProtocol?
    var router: (AccountRoutingLogicProtocol & AccountDataPassing)?
    @IBOutlet weak var deductionAmountTextField: UITextField!
    @IBOutlet weak var deductAmountButton: UIButton!
    
    
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
        
        setUpUI()
        setup()
    }
    
    // MARK: IBActions
    
    @IBAction func deductAmountAction(_ sender: UIButton) {
        
        //if we have an actual amount then move forward with the rest of deduction logic
        guard let deductionAmount = deductionAmountTextField.text, !deductionAmount.isEmpty
        else
        {
            //Display an alert showing that textfield text is empty
            let alertController = UIAlertController(title:"Field Error", message: "Field is mandatory", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { action in}
            alertController.addAction(OKAction)
            self.present(alertController, animated: true)
            return
        }
        //let the interactor send the reqeust to the server
        let request = Account.Request(currentBalance: Double.infinity, amountToBeDeducted:Double(deductionAmount))
        interactor?.deductAmountFromAccount(request:request)
    }
    
    //Protocl method from display protocol
    func displayAccountBalance(viewModel: Account.ViewModel) {
        
        if let _ = viewModel.isTransactionSucessful
        {
            //Call to Router
            router?.routeToNextView()
        }
    }
    
    
    // MARK: Setup UI Elements

    fileprivate func setUpUI() {
        deductionAmountTextField.delegate = self
    }
    
    
    func setup() {
        //This is initial setup of all the components used for a Scene in a Clean Swift architecture.
        let viewController = self
        let interactor = AccountInteractor()
        let presenter = AccountsPresenter()
        let router = AccountsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
//MARK:- TextFieldDelegate
extension AccountsViewController
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

