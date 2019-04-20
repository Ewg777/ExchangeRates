//
//  CurrencyPickerNavigatorOutputMock.swift
//  ExchangeRatesTests
//
//  Created by Ewg on 27.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import UIKit
@testable import ExchangeRates

final class CurrencyPickerNavigatorOutputMock: CurrencyPickerNavigatorOutput {
    var didSelectPairCalled = false

    func currencyPickerNavigator(_ sender: Any, didSelectPair pair: CurrencyPairModel) {
        didSelectPairCalled = true
    }
}
