//
//  CurrencyPairsListAssemble.swift
//  ExchangeRates
//
//  Created by Ewg on 21.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import UIKit

protocol CurrencyPairsListAssembleProtocol: CurrencyModuleBaseAssembleProtocol {

    func assemble(configLoader: ConfigLoaderProtocol, coreData: CoreDataFacadeProtocol) -> UIViewController
}

final class CurrencyPairsListAssemble: CurrencyModuleBaseAssemble {
    private typealias ViewModel = CurrencyPairsListViewModel
    private typealias Router = CurrencyPairsListVCRouter
}

extension CurrencyPairsListAssemble: CurrencyPairsListAssembleProtocol {

    func assemble(configLoader: ConfigLoaderProtocol, coreData: CoreDataFacadeProtocol) -> UIViewController {
        let vc = CurrencyPairsListVC()

        let router = Router(vc: vc, moduleAssemble: moduleAssemble)
        let dataAdapter = SelectedPairCoreDataAdapter()
        let storageService = SelectedPairStorageService(
            adapter: dataAdapter,
            currenciesInfoConfig: configLoader.config.currenciesInfoConfig,
            coreData: coreData
        )
        let viewModel = ViewModel(view: vc, router: router, storageService: storageService)

        vc.setup(viewModel: viewModel)
        return vc
    }
}
