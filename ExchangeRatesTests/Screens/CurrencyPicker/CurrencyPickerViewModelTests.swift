//
//  CurrencyPickerViewModelTests.swift
//  ExchangeRatesTests
//
//  Created by Evgeniy Garkusha on 21/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation

import XCTest
@testable import ExchangeRates

final class CurrencyPickerViewModelTests: XCTestCase {

    var view: CurrencyPickerInputMock!
    var output: CurrencyPickerOutputMock!
    var cellsBuilder: CurrencyPickerCellsBuilder!
    var dataManager: CurrencyPickerDataManager!
    var selectedStorageService: SelectedPairStorageServiceMock!
    var disabledCurrencyFrom: CurrencyModel?

    var vm: CurrencyPickerViewModel!

    var pairs: [CurrencyPairModel]!

    override func setUp() {
        pairs = [
            CurrencyPairModelMock.CreateEURGBP10(),
            CurrencyPairModelMock.CreateGBPEUR5()
        ]

        view = CurrencyPickerInputMock()
        output = CurrencyPickerOutputMock()
        selectedStorageService = SelectedPairStorageServiceMock(pairs: pairs)
        dataManager = CurrencyPickerDataManager()
        cellsBuilder = CurrencyPickerCellsBuilder()
    }

    override func tearDown() {

    }

    func testFirstPageWithNoCurrencySelected() {
        makeVM(disabledCurrencyFrom: nil)

        for cell in dataManager.cells {
            switch cell.type {
            case .listItem(_, let isActive):
                XCTAssertTrue(isActive)
            }
        }
    }

    func testSecondPageWithCurrencySelected() {
        let disabledCurrency = pairs.first!.currencyFrom
        let firstTo = pairs.first!.currencyTo
        let lastTo = pairs.last!.currencyTo
        makeVM(disabledCurrencyFrom: disabledCurrency)

        for cell in dataManager.cells {
            switch cell.type {
            case .listItem(let currency, let isActive):
                if isActive {
                    XCTAssertNotEqual(currency, disabledCurrency)
                } else if currency == disabledCurrency ||
                        currency == firstTo ||
                        currency == lastTo { // we disable currency FROM and all currencies TO
                    XCTAssertTrue(true)
                }
            }
        }
    }

    func makeVM(disabledCurrencyFrom: CurrencyModel?) {
        vm = CurrencyPickerViewModel(
            view: view,
            cellsBuilder: cellsBuilder,
            dataManager: dataManager,
            storageService: selectedStorageService,
            output: output,
            disabledCurrencyFrom: disabledCurrencyFrom
        )
        vm.didLoad()
    }
}
