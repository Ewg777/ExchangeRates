//
//  AmountInCurrency.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

struct AmountInCurrency {
    let currency: CurrencyModel
    let amount: Double?
}

extension AmountInCurrency {

    func formatedAmountCurrency() -> String? {
        guard let amount = amount else {
            return nil
        }
        return String(format: "%.0f %@", amount, currency.code)
    }

    func formatedAmountRate() -> String? {
        guard let amount = amount else {
            return nil
        }
        return String(format: "%.2f", amount)
    }
}
