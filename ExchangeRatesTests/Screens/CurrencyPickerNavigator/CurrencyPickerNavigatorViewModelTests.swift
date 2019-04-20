//
//  CurrencyPickerNavigatorViewModelTests.swift
//  ExchangeRatesTests
//
//  Created by Evgeniy Garkusha on 21/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation

import XCTest
@testable import ExchangeRates

final class CurrencyPickerNavigatorViewModelTests: XCTestCase {

    var view: CurrencyPickerNavigatorInputMock!
    var output: CurrencyPickerNavigatorOutputMock!
    var moduleAssemble: CurrencyModuleAssembleMock!
    var router: CurrencyPickerNavigatorVCRouter!
    var selectedStorageService: SelectedPairStorageServiceMock!
    var vm: CurrencyPickerNavigatorViewModel!
    var pairs: [CurrencyPairModel]!

    override func setUp() {
        pairs = [
            CurrencyPairModelMock.CreateEURGBP10(),
            CurrencyPairModelMock.CreateGBPEUR5()
        ]

        view = CurrencyPickerNavigatorInputMock()
        output = CurrencyPickerNavigatorOutputMock()
        moduleAssemble = CurrencyModuleAssembleMock()
        router = CurrencyPickerNavigatorVCRouter(vc: UIViewController(), moduleAssemble: moduleAssemble)
        selectedStorageService = SelectedPairStorageServiceMock(pairs: pairs)
        vm = CurrencyPickerNavigatorViewModel(
            view: view,
            router: router,
            output: output,
            storageService: selectedStorageService
        )
    }

    override func tearDown() {

    }

    func testCurrencySelection() {
        vm.didLoad()
        XCTAssertTrue(view.addChildCalled) // shows picker

        let from = CurrencyModelMock.CreateEUR()
        vm.currencyPicker(self, didSelectCurrency: from)

        XCTAssertTrue(moduleAssemble.makePickerCalled) // shows second picker

        let to = CurrencyModelMock.CreateGBP()
        vm.currencyPicker(self, didSelectCurrency: to)

        XCTAssertTrue(output.didSelectPairCalled)
    }

    func testSecondCurrencySelectionWithoutFirst() {
        let to = CurrencyModelMock.CreateGBP()
        vm.currencyPicker(self, didSelectCurrency: to)

        XCTAssertFalse(moduleAssemble.makePickerNavigatorCalled) // doesn't show second picker
    }
}

