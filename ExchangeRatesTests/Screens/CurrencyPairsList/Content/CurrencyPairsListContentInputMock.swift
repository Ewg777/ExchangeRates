//
//  CurrencyPairsListContentInputMock.swift
//  ExchangeRatesTests
//
//  Created by Ewg on 27.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

@testable import ExchangeRates

final class CurrencyPairsListContentInputMock: CurrencyPairsListContentInput {

    var showAlertCalled = false
    var reloadCalled = false

    func listContent(_ sender: Any, showAlert message: String) {
        showAlertCalled = true
    }
    
    func reload() {
        reloadCalled = true
    }
}
