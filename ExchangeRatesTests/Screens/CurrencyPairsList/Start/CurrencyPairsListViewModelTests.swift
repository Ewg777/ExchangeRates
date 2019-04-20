//
//  CurrencyPairsListViewModelTests.swift
//  ExchangeRatesTests
//
//  Created by Evgeniy Garkusha on 21/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation

import XCTest
@testable import ExchangeRates

final class CurrencyPairsListViewModelTests: XCTestCase {

    var view: CurrencyPairsListViewInputMock!
    var moduleAssemble: CurrencyModuleAssembleMock!
    var router: CurrencyPairsListVCRouter!
    var storageService: SelectedPairStorageServiceMock!
    var vm: CurrencyPairsListViewModel!

    var pairs: [CurrencyPairModel]!

    override func setUp() {
        pairs = [
            CurrencyPairModelMock.CreateEURGBP10(),
            CurrencyPairModelMock.CreateGBPEUR5()
        ]
        view = CurrencyPairsListViewInputMock()
        moduleAssemble = CurrencyModuleAssembleMock()
        router = CurrencyPairsListVCRouter(vc: UIViewController(), moduleAssemble: moduleAssemble)
        storageService = SelectedPairStorageServiceMock(pairs: pairs)
        vm = CurrencyPairsListViewModel(
            view: view,
            router: router,
            storageService: storageService
        )

        vm.didLoad()
    }

    override func tearDown() {

    }


    func testDeletingAllItemsToShowEmpty() {
        let firstPair = pairs.first!
        let lastPair = pairs.last!

        XCTAssertEqual(pairs.count, 2)
        storageService.pairs.removeFirst()

        vm.pairsList(self, deleteCurrencyPair: firstPair)


        XCTAssertNotNil(storageService.deletedPair)
        XCTAssertNotNil(view.updateChildCalled)

//        switch view.updatedViewState! {
//        case .content(let newPairs):
//            XCTAssertEqual(newPairs.count, 1)
//        case .empty:
//            XCTAssertTrue(false)
//        }

        storageService.deletedPair = nil // reset
        storageService.pairs.removeFirst()

        vm.pairsList(self, deleteCurrencyPair: lastPair)

        XCTAssertNotNil(storageService.deletedPair)
        XCTAssertNotNil(view.updateChildCalled)

//        switch view.updatedViewState! {
//        case .content(_):
//            XCTAssertTrue(false)
//        case .empty:
//            XCTAssertTrue(true)
//        }
    }
}
