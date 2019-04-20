//
//  CurrencyModuleAssembleMock.swift
//  ExchangeRatesTests
//
//  Created by Ewg on 27.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import UIKit

@testable import ExchangeRates

final class CurrencyModuleAssembleMock: CurrencyModuleAssembleProtocol {
    var makePickerCalled = false
    var makeListCalled = false
    var makePickerNavigatorCalled = false
    var makeContentCalled = false
    var makeEmptyCalled = false

    func makePicker(disabledCurrencyFrom: CurrencyModel?, delegate: CurrencyPickerOutput) -> UIViewController {
        makePickerCalled = true
        return UIViewController()
    }

    func makeList() -> UIViewController {
        makeListCalled = true
        return UIViewController()
    }

    func makePickerNavigator(delegate: CurrencyPickerNavigatorOutput) -> UIViewController {
        makePickerNavigatorCalled = true
        return UIViewController()
    }

    func makeContent(pairs: [CurrencyPairModel], listContainerDelegate: CurrencyPairsListOutput) -> UIViewController {
        makeContentCalled = true
        return UIViewController()
    }

    func makeEmpty(delegate: CurrencyPairsListOutput) -> UIViewController {
        makeEmptyCalled = true
        return UIViewController()
    }
}
