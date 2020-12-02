//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by Ashish on 02/10/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - CurrencyModel
final class CurrencyModel : Object, Codable {
    dynamic let success: Bool
    dynamic let terms, privacy: String
    dynamic let timestamp: Int
    dynamic let source: String
    dynamic let quotes: [String: Double]
}

extension CurrencyModel : NetworkParser {
    
    static func parseObject(data: Data) -> Result<CurrencyModel, ErrorResult> {
        do {
            let newModel = try JSONDecoder().decode(CurrencyModel.self, from: data)
            return Result.success(newModel)
        } catch {
            return Result.failure(ErrorResult.parser(string: "parser error \(#function) \(#line)"))
        }
    }
}
