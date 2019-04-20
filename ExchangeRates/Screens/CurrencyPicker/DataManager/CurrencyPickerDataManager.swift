//
//  CurrencyPickerDataManager.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

protocol CurrencyPickerDataManagerProtocol {

    var cells: [CurrencyPickerCellDataModel] { get }

    func update(newCells: [CurrencyPickerCellDataModel])
}

final class CurrencyPickerDataManager: CurrencyPickerDataManagerProtocol {

    var cells: [CurrencyPickerCellDataModel] = []

    func update(newCells: [CurrencyPickerCellDataModel]) {
        cells = newCells
    }
}
