//
//  CurrencyPairsListContentDataManager.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation

final class CurrencyPairsListContentDataManager {

    var cells: [CurrencyPairsListContentCellDataModel] = []

    func update(newCells: [CurrencyPairsListContentCellDataModel]) {
        cells = newCells
    }
}
