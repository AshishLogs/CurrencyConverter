//
//  RealmManager.swift
//  CurrencyConverter
//
//  Created by Ashish on 02/10/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager: CurrencyServiceProtocol {
    
    func fetchConverter(_ completion: @escaping ((Result<CurrencyModel, ErrorResult>) -> Void)) {
        let realmModel = fetch(CurrencyModel.self)
        if let model = realmModel.first {
            completion(.success(model))
        } else {
            completion(.failure(.custom(string: "fetch failed")))
        }
    }
    
    
    /// database variable for Realm
    private var database: Realm
    
    /// singleton model for realm manager
    static let shared = RealmManager()
    
    private init() {
        database = try! Realm()
    }
    
    
    /// fetch user model
    /// - Parameter name:  T.Type which conforms to Object
    /// - Returns: Results<T> - T is generic type conforms to Object
    func fetch<T: Object>(_ name: T.Type) -> Results<T> {
        let results: Results<T> =   database.objects(name)
        return results
    }
    
    /// fetch user model
    /// - Parameter predicate: NSPredicate
    /// - Returns: Results<T>
    func fetch<T: Object>(predicate: NSPredicate) -> Results<T> {
        let results: Results<T> =   database.objects(T.self).filter(predicate)
        return results
    }
    
    /// adding object to database
    /// - Parameter object: Object
    func add(_ object: Object)   {
        try! database.write {
            database.add(object)
        }
    }
    
    /// delete database
    func deleteDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    
    /// delete current Object
    /// - Parameter object: Object
    func delete( _ object: Object) {
        database.delete(object)
    }
        
}
