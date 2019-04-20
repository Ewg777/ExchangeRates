//
//  CurrencyPairsListContentViewModelTests.swift
//  ExchangeRatesTests
//
//  Created by Evgeniy Garkusha on 21/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation

import XCTest
@testable import ExchangeRates

final class CurrencyPairsListContentViewModelTests: XCTestCase {

    var view: CurrencyPairsListContentInputMock!

    var moduleAssemble: CurrencyModuleAssembleMock!
    var router: CurrencyPairsListContentVCRouter!
    var dataManager: CurrencyPairsListContentDataManager!
    var cellsBuilder: CurrencyPairsListContentCellsBuilder!
    var apiRatesService: ApiRatesServiceMock!
    var ratesUpdaterService: RatesUpdaterService!
    var listContainerDelegate: CurrencyPairsListOutputMock!
    var vm: CurrencyPairsListContentViewModel!

    var rates: [CurrencyRateModel]!

    override func setUp() {
        rates = [
            CurrencyRateModelMock.CreateEURGBP10(),
            CurrencyRateModelMock.CreateGBPEUR5()
        ]

        moduleAssemble = CurrencyModuleAssembleMock()
        router = CurrencyPairsListContentVCRouter(vc: UIViewController(), moduleAssemble: moduleAssemble)
        dataManager = CurrencyPairsListContentDataManager()
        cellsBuilder = CurrencyPairsListContentCellsBuilder()
        apiRatesService = ApiRatesServiceMock(result: rates)
        ratesUpdaterService = RatesUpdaterService(apiRatesService: apiRatesService)
        listContainerDelegate = CurrencyPairsListOutputMock()
        view = CurrencyPairsListContentInputMock()

        let pairs = [
            CurrencyPairModelMock.CreateEURGBP10(),
            CurrencyPairModelMock.CreateGBPEUR5()
        ]
        makeVM(currencyPairs: pairs)
        vm.didLoad()
    }

    override func tearDown() {

    }

    func testAddNew() {
        vm.didSelectAddNew()

        XCTAssertTrue(listContainerDelegate.addTapped)
    }

    func testDeleteRate() {
        let rateItem = rates.first!
        vm.didSelect(rateItem: rateItem)

        guard let deletedPair = listContainerDelegate.deletedPair else {
            XCTAssertNotNil(nil)
            return
        }

        XCTAssertEqual(deletedPair.currencyFrom, rateItem.from.currency)
        XCTAssertEqual(deletedPair.currencyTo, rateItem.to.currency)
    }

    func testRefreshing() {
        let delayExpectation = expectation(description: "Waiting for rates get refreshed")
        vm.willAppear()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.dataManager.cells.count, self.rates.count + 1)// rates + add button
            delayExpectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testStoppingRefreshing() {
        let delayExpectation = expectation(description: "Waiting for rates get refreshed")
        vm.willAppear()
        vm.willDisappear()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.dataManager.cells.count, 0) // no cells loaded
            delayExpectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    // MARK: - Helper
    private func makeVM(currencyPairs: [CurrencyPairModel]) {
        vm = CurrencyPairsListContentViewModel(
            view: view,
            router: router,
            cellsBuilder: cellsBuilder,
            dataManager: dataManager,
            ratesUpdaterService: ratesUpdaterService,
            listContainerDelegate: listContainerDelegate,
            currencyPairs: currencyPairs
        )
    }
}
