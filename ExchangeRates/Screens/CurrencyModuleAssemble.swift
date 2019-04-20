//
//  CurrencyModuleAssemble.swift
//  ExchangeRates
//
//  Created by Ewg on 21.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import UIKit

protocol CurrencyModuleAssembleProtocol {

    func makePicker(disabledCurrencyFrom: CurrencyModel?, delegate: CurrencyPickerOutput) -> UIViewController

    func makeList() -> UIViewController

    func makePickerNavigator(delegate: CurrencyPickerNavigatorOutput) -> UIViewController

    func makeContent(pairs: [CurrencyPairModel], listContainerDelegate: CurrencyPairsListOutput) -> UIViewController
    
    func makeEmpty(delegate: CurrencyPairsListOutput) -> UIViewController
}

final class CurrencyModuleAssemble: CurrencyModuleAssembleProtocol {
    private let configLoader: ConfigLoaderProtocol
    private let coreData: CoreDataFacadeProtocol

    init(configLoader: ConfigLoaderProtocol, coreData: CoreDataFacadeProtocol) {
        self.configLoader = configLoader
        self.coreData = coreData
    }

    func makePicker(disabledCurrencyFrom: CurrencyModel?, delegate: CurrencyPickerOutput) -> UIViewController {
        let assembler = CurrencyPickerAssemble(moduleAssemble: self)
        return assembler.assemble(
            configLoader: configLoader,
            coreData: coreData,
            disabledCurrencyFrom: disabledCurrencyFrom,
            delegate: delegate
        )
    }

    func makeList() -> UIViewController {
        let assembler = CurrencyPairsListAssemble(moduleAssemble: self)
        return assembler.assemble(configLoader: configLoader, coreData: coreData)
    }

    func makePickerNavigator(delegate: CurrencyPickerNavigatorOutput) -> UIViewController {
        let assembler = CurrencyPickerNavigatorAssemble(moduleAssemble: self)
        return assembler.assemble(
            configLoader: configLoader,
            coreData: coreData,
            delegate: delegate
        )
    }

    func makeContent(pairs: [CurrencyPairModel], listContainerDelegate: CurrencyPairsListOutput) -> UIViewController {
        let assembler = CurrencyPairsListContentAssemble(moduleAssemble: self)
        return assembler.assemble(
            currencyPairs: pairs,
            configLoader: configLoader,
            listContainerDelegate: listContainerDelegate
        )
    }

    func makeEmpty(delegate: CurrencyPairsListOutput) -> UIViewController {
        let assembler = CurrencyPairsListEmptyAssemble(moduleAssemble: self)
        return assembler.assemble(delegate: delegate)
    }
}
