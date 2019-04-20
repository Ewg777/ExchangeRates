//
//  CurrencyPickerAssemble.swift
//  ExchangeRates
//
//  Created by Ewg on 21.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import UIKit

protocol CurrencyPickerAssembleProtocol: AnyObject {

    func assemble(
        configLoader: ConfigLoaderProtocol,
        coreData: CoreDataFacadeProtocol,
        disabledCurrencyFrom: CurrencyModel?,
        delegate: CurrencyPickerOutput
    ) -> UIViewController
}

final class CurrencyPickerAssemble: CurrencyModuleBaseAssemble {
    private typealias ViewModel = CurrencyPickerViewModel

}

extension CurrencyPickerAssemble: CurrencyPickerAssembleProtocol {

    func assemble(
        configLoader: ConfigLoaderProtocol,
        coreData: CoreDataFacadeProtocol,
        disabledCurrencyFrom: CurrencyModel? = nil,
        delegate: CurrencyPickerOutput
    ) -> UIViewController {
        let vc = CurrencyPickerVC(disabledCurrencyFrom: disabledCurrencyFrom)

        let dataManager = CurrencyPickerDataManager()
        let cellsBuilder = CurrencyPickerCellsBuilder()
        let dataAdapter = SelectedPairCoreDataAdapter()
        let storageService = SelectedPairStorageService(
            adapter: dataAdapter,
            currenciesInfoConfig: configLoader.config.currenciesInfoConfig,
            coreData: coreData
        )
        let viewModel = ViewModel(
            view: vc,
            cellsBuilder: cellsBuilder,
            dataManager: dataManager,
            storageService: storageService,
            output: delegate,
            disabledCurrencyFrom: disabledCurrencyFrom)

        vc.setup(viewModel: viewModel)
        return vc
    }
}
