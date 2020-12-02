//
//  CurrencyModelTest.swift
//  CurrencyConverterTests
//
//  Created by Ashish on 02/12/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import XCTest

@testable import CurrencyConverter

class CurrencyModelTests: XCTestCase {
    
    func testParseEmptyCurrency() {
        
        // giving empty data
        let data = Data()
        
        // giving completion after parsing
        // expected valid converter with valid data
        let completion : ((Result<CurrencyModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .success(_):
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
        
        ParserHelper.parse(data: data, completion: completion)
    }
    
    func testWrongKeyCurrency() {
        
        // giving a wrong dictionary
        let data = Data()
        
        // expected to return error of converter
        let result = CurrencyModel.parseObject(data: data)
        
        switch result {
        case .success(_):
            XCTAssert(false, "Expected failure when wrong data")
        default:
            return
        }
    }
}
