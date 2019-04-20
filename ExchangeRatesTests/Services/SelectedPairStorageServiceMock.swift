//
//  SelectedPairStorageServiceMock.swift
//  ExchangeRatesTests
//
//  Created by Evgeniy Garkusha on 21/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

@testable import ExchangeRates

final class SelectedPairStorageServiceMock: SelectedPairStorageServiceProtocol {

    var savedPair: CurrencyPairModel?
    var deletedPair: CurrencyPairModel?

    var pairs: [CurrencyPairModel]

    init(pairs: [CurrencyPairModel]) {
        self.pairs = pairs
    }

    func getAllCurrencies() -> [CurrencyModel] {
        []
    }

    func getAllPairsSync() -> [CurrencyPairModel]? {
        pairs
    }

    func getAllPairsSync(from currency: CurrencyModel) -> [CurrencyPairModel]? {
        pairs
    }

    func saveSync(pair: CurrencyPairModel) {
        savedPair = pair
    }

    func deleteSync(pair: CurrencyPairModel) {
        deletedPair = pair
    }
}
