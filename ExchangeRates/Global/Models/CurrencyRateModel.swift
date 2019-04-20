//
//  CurrencyRateModel.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

struct CurrencyRateModel {
    let from: AmountInCurrency
    let to: AmountInCurrency
}

extension CurrencyRateModel {
    func toPairModel() -> CurrencyPairModel {
        return CurrencyPairModel(currencyFrom: from.currency, currencyTo: to.currency)
    }
}
