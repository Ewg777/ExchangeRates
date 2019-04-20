//
//  CurrencyPairsListContentAssemble.swift
//  ExchangeRates
//
//  Created by Ewg on 21.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import UIKit

protocol CurrencyPairsListContentAssembleProtocol: CurrencyModuleBaseAssembleProtocol {

    func assemble(
        currencyPairs: [CurrencyPairModel],
        configLoader: ConfigLoaderProtocol,
        listContainerDelegate: CurrencyPairsListOutput
    ) -> UIViewController
}

final class CurrencyPairsListContentAssemble: CurrencyModuleBaseAssemble {
    private typealias ViewModel = CurrencyPairsListContentViewModel
    private typealias Router = CurrencyPairsListContentVCRouter
}

extension CurrencyPairsListContentAssemble: CurrencyPairsListContentAssembleProtocol {

    func assemble(
        currencyPairs: [CurrencyPairModel],
        configLoader: ConfigLoaderProtocol,
        listContainerDelegate: CurrencyPairsListOutput
    ) -> UIViewController {
        let vc = CurrencyPairsListContentVC()

        let router = Router(vc: vc, moduleAssemble: moduleAssemble)
        let dataManager = CurrencyPairsListContentDataManager()
        let cellsBuilder = CurrencyPairsListContentCellsBuilder()
        let urlSession = URLSession.shared
        let mapper = ApiRatesMapper()
        let apiRatesService = ApiRatesService(
            urlSession: urlSession,
            mapper: mapper,
            baseURL: configLoader.config.apiEndPointURL
        )
        let ratesUpdaterService = RatesUpdaterService(apiRatesService: apiRatesService)
        let viewModel = ViewModel(
            view: vc,
            router: router,
            cellsBuilder: cellsBuilder,
            dataManager: dataManager,
            ratesUpdaterService: ratesUpdaterService,
            listContainerDelegate: listContainerDelegate,
            currencyPairs: currencyPairs
        )

        vc.setup(viewModel: viewModel)
        return vc
    }
}

