//
//  CurrencyPairsListOutputMock.swift
//  ExchangeRatesTests
//
//  Created by Ewg on 28.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

@testable import ExchangeRates

final class CurrencyPairsListOutputMock: CurrencyPairsListOutput {
    var addTapped = false
    var deletedPair: CurrencyPairModel?
    func pairsList(_ sender: Any, onAddCurrencyPairTap: Any?) {
        addTapped = true
    }

    func pairsList(_ sender: Any, deleteCurrencyPair pair: CurrencyPairModel) {
        deletedPair = pair
    }
}
