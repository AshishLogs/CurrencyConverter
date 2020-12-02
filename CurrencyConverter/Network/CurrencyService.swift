//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by Ashish on 02/10/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit

protocol CurrencyServiceProtocol : class {
    func fetchConverter(_ completion: @escaping ((Result<CurrencyModel, ErrorResult>) -> Void))
}

final class CurrencyService : NetworkHandler, CurrencyServiceProtocol {
    
    static let shared = CurrencyService()
    let endpoint = "http://api.currencylayer.com/live?access_key=64e96332e0778cd01db58ea9b76d81cb"
    var task : URLSessionTask?
    
    func fetchConverter(_ completion: @escaping ((Result<CurrencyModel, ErrorResult>) -> Void)) {

        self.cancelFetchCurrencies()
        
        task = NetworkService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchCurrencies() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
