//
//  SelectedPairStorageService.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import CoreData

protocol SelectedPairStorageServiceProtocol: AnyObject {

    func getAllCurrencies() -> [CurrencyModel]
    func getAllPairsSync() -> [CurrencyPairModel]?
    func getAllPairsSync(from currency: CurrencyModel) -> [CurrencyPairModel]?
    func saveSync(pair: CurrencyPairModel)
    func deleteSync(pair: CurrencyPairModel)
}


final class SelectedPairStorageService {
    private let adapter: SelectedPairCoreDataAdapterProtocol
    private let currenciesInfoConfig: CurrenciesInfoConfig
    private let coreData: CoreDataFacadeProtocol

    init(
        adapter: SelectedPairCoreDataAdapterProtocol,
        currenciesInfoConfig: CurrenciesInfoConfig,
        coreData: CoreDataFacadeProtocol
    ) {
        self.adapter = adapter
        self.currenciesInfoConfig = currenciesInfoConfig
        self.coreData = coreData
    }
}

// MARK: - SelectedPairStorageServiceProtocol
extension SelectedPairStorageService: SelectedPairStorageServiceProtocol {

    func getAllCurrencies() -> [CurrencyModel] {
        currenciesInfoConfig.currenciesInfo
    }

    func getAllPairsSync() -> [CurrencyPairModel]? {
        let cPairs = getAllPairsCoreData()
        return cPairs?.compactMap {
            adapter.convertToPlainModel(coreDataModel: $0, currenciesConfig: currenciesInfoConfig)
        }
    }

    func getAllPairsSync(from currency: CurrencyModel) -> [CurrencyPairModel]? {
        let predicate = NSPredicate(format: "currencyCodeFrom = %@", currency.code)
        let cPairs = getAllPairsCoreData(predicate: predicate)
        return cPairs?.compactMap {
            adapter.convertToPlainModel(coreDataModel: $0, currenciesConfig: currenciesInfoConfig)
        }
    }

    func saveSync(pair: CurrencyPairModel) {
        let cdModel: SelectedPairCoreDataModel? = coreData.createSync()
        cdModel?.currencyCodeFrom = pair.currencyFrom.code
        cdModel?.currencyCodeTo = pair.currencyTo.code
    }

    func deleteSync(pair: CurrencyPairModel) {
        let predicate = NSPredicate(
            format: "(currencyCodeFrom = %@) AND (currencyCodeTo = %@)",
            pair.currencyFrom.code,
            pair.currencyTo.code
        )

        guard let cPairs = getAllPairsCoreData(predicate: predicate) else { return }
        coreData.deleteSync(cPairs)
    }

    private func getAllPairsCoreData(predicate: NSPredicate? = nil) -> [SelectedPairCoreDataModel]? {
        coreData.fetchSync(predicate: predicate)
    }
}
