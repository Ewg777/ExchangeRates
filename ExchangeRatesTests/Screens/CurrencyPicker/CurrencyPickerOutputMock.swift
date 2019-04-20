//
//  CurrencyPickerOutputMock.swift
//  ExchangeRatesTests
//
//  Created by Ewg on 27.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

@testable import ExchangeRates

final class CurrencyPickerOutputMock: CurrencyPickerOutput {
    var didSelectCurrency = false
    func currencyPicker(_ sender: Any, didSelectCurrency currency: CurrencyModel) {
        didSelectCurrency = true
    }
}
