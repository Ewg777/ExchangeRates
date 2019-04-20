//
//  CurrencyPairsListContentCellsBuilderTests.swift
//  ExchangeRatesTests
//
//  Created by Evgeniy Garkusha on 21/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation

import XCTest
@testable import ExchangeRates

final class CurrencyPairsListContentCellsBuilderTests: XCTestCase {

    var builder: CurrencyPairsListContentCellsBuilder!

    override func setUp() {
        builder = CurrencyPairsListContentCellsBuilder()
    }

    override func tearDown() {

    }

    func testListBuilding() {
        let list = [
            CurrencyRateModelMock.CreateEURGBP10(),
            CurrencyRateModelMock.CreateGBPEUR5()
        ]
        let cells = builder.makeList(currencyRates: list)

        XCTAssertEqual(cells.count, 3) // should contains "add" cell
    }
}
