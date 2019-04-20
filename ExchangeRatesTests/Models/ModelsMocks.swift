//
//  ModelsMocks.swift
//  ExchangeRatesTests
//
//  Created by Evgeniy Garkusha on 21/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation
@testable import ExchangeRates

final class CurrencyModelMock {

    static func CreateEUR() -> CurrencyModel {
        let json = """
{"code": "EUR","title": "Euro","countryISOCode": "EU","countryFlag": "EU"}
"""
        let decoder = JSONDecoder()
        return try! decoder.decode(CurrencyModel.self, from: json.data(using: .utf8)!)
    }

    static func CreateGBP() -> CurrencyModel {
        let json = """
{"code": "GBP","title": "British Pound","countryISOCode": "UK","countryFlag": "UK"}
"""
        let decoder = JSONDecoder()
        return try! decoder.decode(CurrencyModel.self, from: json.data(using: .utf8)!)
    }
}


final class CurrencyRateModelMock {

    static func CreateEURGBP10() -> CurrencyRateModel {
        let from = CurrencyModelMock.CreateEUR()
        let to = CurrencyModelMock.CreateGBP()
        return CurrencyRateModel(from: .init(currency: from, amount: 1), to: .init(currency: to, amount: 10))
    }

    static func CreateGBPEUR5() -> CurrencyRateModel {
        let from = CurrencyModelMock.CreateGBP()
        let to = CurrencyModelMock.CreateEUR()
        return CurrencyRateModel(from: .init(currency: from, amount: 1), to: .init(currency: to, amount: 5))
    }
}

final class CurrencyPairModelMock {

    static func CreateEURGBP10() -> CurrencyPairModel {
        let from = CurrencyModelMock.CreateEUR()
        let to = CurrencyModelMock.CreateGBP()
        return CurrencyPairModel(currencyFrom: from, currencyTo: to)
    }

    static func CreateGBPEUR5() -> CurrencyPairModel {
        let from = CurrencyModelMock.CreateGBP()
        let to = CurrencyModelMock.CreateEUR()
        return CurrencyPairModel(currencyFrom: from, currencyTo: to)
    }
}
