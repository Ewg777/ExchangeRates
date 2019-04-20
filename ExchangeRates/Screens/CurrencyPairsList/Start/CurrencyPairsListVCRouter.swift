//
//  CurrencyPairsListVCRouter.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

final class CurrencyPairsListVCRouter: BaseRouter {

    func makeEmpty(delegate: CurrencyPairsListOutput) -> UIViewController {
        moduleAssemble.makeEmpty(delegate: delegate)
    }

    func makeContent(pairs: [CurrencyPairModel], listContainerDelegate: CurrencyPairsListOutput) -> UIViewController {
        moduleAssemble.makeContent(pairs: pairs, listContainerDelegate: listContainerDelegate)
    }

    func showCurrencyPickerNavigator(delegate: CurrencyPickerNavigatorOutput) {
        let vc = moduleAssemble.makePickerNavigator(delegate: delegate)
        present(vc: vc)
    }
}
