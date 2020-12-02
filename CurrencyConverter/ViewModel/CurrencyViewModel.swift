//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Ashish on 02/10/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit

struct CurrencyViewModel {
    
    weak var service: CurrencyService?
    
    var datasource : CurrencyDataSource?

    var onErrorHandling : ((ErrorResult?) -> Void)?
    
    init(service : CurrencyService = CurrencyService.shared, datasource: CurrencyDataSource) {
        self.service = service
        self.datasource = datasource
    }
    
    func fetchCurrenciesList() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "service error"))
            return
        }
        
        service.fetchConverter { (result) in
            switch result {
            case .success(let model):
                self.datasource?.handleModel(model: model)
            case .failure(_):
                break
            }
        }
    }
    
}
