//
//  NetworkParser.swift
//  CurrencyConverter
//
//  Created by Ashish on 02/10/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit

protocol NetworkParser {
    static func parseObject(data: Data) -> Result<Self, ErrorResult>
}

final class ParserHelper {
    
    static func parse<T: NetworkParser>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        
        switch T.parseObject(data: data) {
        case .success(let model):
            completion(.success(model))
        case .failure(_):
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
    
}
