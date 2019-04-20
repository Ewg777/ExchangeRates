//
//  CurrencyPairModel.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation

struct CurrencyPairModel {
    let currencyFrom: CurrencyModel
    let currencyTo: CurrencyModel
}

// MARK: - Networking
extension CurrencyPairModel {
    func toQuery() -> String {
        return (currencyFrom.code + currencyTo.code).uppercased()
    }
}
