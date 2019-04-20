//
//  CurrencyPickerNavigatorInputMock.swift
//  ExchangeRatesTests
//
//  Created by Ewg on 27.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import UIKit
@testable import ExchangeRates

final class CurrencyPickerNavigatorInputMock: CurrencyPickerNavigatorInput {
    var addChildCalled = false

    func addChild(vc: UIViewController) {
        addChildCalled = true
    }
}
