//
//  Account.swift
//  Accounts
//
//  Created by Kashif Mehmood on 19/02/2019.
//  Copyright © 2019 Kashif. All rights reserved.
//

import Foundation

//Entity or Model
enum Account
{
struct Request {
    var currentBalance: Double?
    var amountToBeDeducted:Double?
}

struct Response {
    var isTransactionSucessful: Bool?
}

struct ViewModel {
    var isTransactionSucessful: Bool?
}
}
