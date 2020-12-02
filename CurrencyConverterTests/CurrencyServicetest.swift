//
//  NetworkServicetest.swift
//  CurrencyConverterTests
//
//  Created by Ashish on 02/12/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import XCTest

@testable import CurrencyConverter

class CurrencyServiceTests: XCTestCase {
    
    func testCancelRequest() {
        
        // giving a "previous" session
        CurrencyService.shared.fetchConverter { (_) in
            // ignore call
        }
        
        // Expected to task nil after cancel
        CurrencyService.shared.cancelFetchCurrencies()
        XCTAssertNil(CurrencyService.shared.task, "Expected nil")
    }
}
