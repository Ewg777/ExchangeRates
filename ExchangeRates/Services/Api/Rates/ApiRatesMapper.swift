//
//  ApiRatesMapper.swift
//  ExchangeRates
//
//  Created by Ewg on 21.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import Foundation

protocol ApiRatesMapperProtocol: AnyObject {
    func mapToRates(pairs: [CurrencyPairModel], from dict: [String: Double]) -> [CurrencyRateModel]
}

final class ApiRatesMapper: ApiRatesMapperProtocol {

    func mapToRates(pairs: [CurrencyPairModel], from obj: [String: Double]) -> [CurrencyRateModel] {
        pairs.map {
            let key = $0.toQuery()
            let rateValue = obj[key]
            return CurrencyRateModel(
                from: AmountInCurrency(
                    currency: $0.currencyFrom,
                    amount: 1
                ),
                to: AmountInCurrency(
                    currency: $0.currencyTo,
                    amount: rateValue
                )
            )
        }
    }
}
