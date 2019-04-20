//
//  CurrencyPickerInputMock.swift
//  ExchangeRatesTests
//
//  Created by Ewg on 27.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

@testable import ExchangeRates

final class CurrencyPickerInputMock: CurrencyPickerInput {
    var wasReloaded = false

    func reload() {
        wasReloaded = true
    }
}
