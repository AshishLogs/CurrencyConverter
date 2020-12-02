//
//  CurrencyDataSource.swift
//  CurrencyConverter
//
//  Created by Ashish on 02/10/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit


class CurrencyDataSource : NSObject {
    
    var currencyModel : CurrencyModel? {
        didSet {
            self.notify()
        }
    }
    
    typealias CompletionHandler = ((CurrencyModel) -> Void)
    
    private var observers = [String: CompletionHandler]()

    
    func handleModel(model: CurrencyModel) {
        RealmManager.shared.add(model)
        self.currencyModel = model
    }
    
    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify() {
        if let currency = self.currencyModel {
            observers.forEach{$0.value(currency)}
        }
    }
    
    deinit {
        observers.removeAll()
    }

}
