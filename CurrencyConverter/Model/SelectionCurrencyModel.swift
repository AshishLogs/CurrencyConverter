//
//  SelectionCurrencyModel.swift
//  CurrencyConverter
//
//  Created by Ashish on 02/10/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit

struct SelectionCurrencyModel: CurrencyHelpers {
    
    var to : String
    var from: String
    var toFlag: String {
        return flag(country: String(to.dropLast()))
    }
    var fromFlag: String {
        return flag(country: String(from.dropLast()))
    }
    
    init(to: String, from: String) {
        self.to = to
        self.from = from
    }
    
}
