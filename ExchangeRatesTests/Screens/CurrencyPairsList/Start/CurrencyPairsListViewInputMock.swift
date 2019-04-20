//
//  CurrencyPairsListViewInputMock.swift
//  ExchangeRatesTests
//
//  Created by Ewg on 27.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import UIKit
@testable import ExchangeRates

final class CurrencyPairsListViewInputMock: CurrencyPairsListViewInput {
    var updateChildCalled = false

    func updateChild(with vc: UIViewController) {
        updateChildCalled = true
    }
}
