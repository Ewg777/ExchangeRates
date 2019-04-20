//
//  CurrencyPickerCellsBuilder.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

protocol CurrencyPickerCellsBuilderProtocol: AnyObject {

    func makeList(
        _ currencies: [CurrencyModel],
        disabledCurrencies: [CurrencyModel]
    ) -> [CurrencyPickerCellDataModel]
}

final class CurrencyPickerCellsBuilder: CurrencyPickerCellsBuilderProtocol {

    func makeList(
        _ currencies: [CurrencyModel],
        disabledCurrencies: [CurrencyModel]
    ) -> [CurrencyPickerCellDataModel] {
        currencies.map {
            let isDisabled = disabledCurrencies.contains($0)
            return CurrencyPickerCellDataModel(type: .listItem(currency: $0, isActive: !isDisabled))
        }
    }
}
