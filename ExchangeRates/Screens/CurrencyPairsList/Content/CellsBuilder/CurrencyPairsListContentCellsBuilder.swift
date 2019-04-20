//
//  CurrencyPairsListContentCellsBuilder.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation

final class CurrencyPairsListContentCellsBuilder {

    func makeList(currencyRates: [CurrencyRateModel]) -> [CurrencyPairsListContentCellDataModel] {
        var result: [CurrencyPairsListContentCellDataModel] = []

        result.append(.init(type: .addNew))

        let rateItems = currencyRates.map {
            CurrencyPairsListContentCellDataModel(type: .rateItem(rate: $0))
        }
        result.append(contentsOf: rateItems)

        return result
    }
}
