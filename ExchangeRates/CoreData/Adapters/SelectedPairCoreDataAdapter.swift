//
//  SelectedPairCoreDataAdapter.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

protocol SelectedPairCoreDataAdapterProtocol: AnyObject {
    func convertToPlainModel(
        coreDataModel: SelectedPairCoreDataModel,
        currenciesConfig: CurrenciesInfoConfig
    ) -> CurrencyPairModel?
}

final class SelectedPairCoreDataAdapter {}

extension SelectedPairCoreDataAdapter: SelectedPairCoreDataAdapterProtocol {

    func convertToPlainModel(
        coreDataModel: SelectedPairCoreDataModel,
        currenciesConfig: CurrenciesInfoConfig
    ) -> CurrencyPairModel? {
        let currenciesInfo = currenciesConfig.currenciesInfo
        guard
            let currencyModelFrom = currenciesInfo.get(byCode: coreDataModel.currencyCodeFrom),
            let currencyModelTo = currenciesInfo.get(byCode: coreDataModel.currencyCodeTo)
            else {
                return nil
        }
        return CurrencyPairModel(currencyFrom: currencyModelFrom, currencyTo: currencyModelTo)
    }
}
