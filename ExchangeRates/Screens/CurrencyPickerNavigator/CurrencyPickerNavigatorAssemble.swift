//
//  CurrencyPickerNavigatorAssemble.swift
//  ExchangeRates
//
//  Created by Ewg on 21.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import UIKit

protocol CurrencyPickerNavigatorAssembleProtocol: AnyObject {

    func assemble(
        configLoader: ConfigLoaderProtocol,
        coreData: CoreDataFacadeProtocol,
        delegate: CurrencyPickerNavigatorOutput
    ) -> UIViewController
}

final class CurrencyPickerNavigatorAssemble: CurrencyModuleBaseAssemble {
    private typealias ViewModel = CurrencyPickerNavigatorViewModel
    private typealias Router = CurrencyPickerNavigatorVCRouter

}

extension CurrencyPickerNavigatorAssemble: CurrencyPickerNavigatorAssembleProtocol {

    func assemble(
        configLoader: ConfigLoaderProtocol,
        coreData: CoreDataFacadeProtocol,
        delegate: CurrencyPickerNavigatorOutput
    ) -> UIViewController {
        let vc = CurrencyPickerNavigatorVC()

        let router = CurrencyPickerNavigatorVCRouter(vc: vc, moduleAssemble: moduleAssemble)
        let dataAdapter = SelectedPairCoreDataAdapter()
        let storageService = SelectedPairStorageService(
            adapter: dataAdapter,
            currenciesInfoConfig: configLoader.config.currenciesInfoConfig,
            coreData: coreData
        )
        let viewModel = CurrencyPickerNavigatorViewModel(
            view: vc,
            router: router,
            output: delegate,
            storageService: storageService
        )

        vc.setup(viewModel: viewModel)
        return UINavigationController(rootViewController: vc)
    }
}
