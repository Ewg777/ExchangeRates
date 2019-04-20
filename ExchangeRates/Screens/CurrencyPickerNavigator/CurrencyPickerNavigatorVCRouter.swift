//
//  CurrencyPickerNavigatorVCRouter.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

final class CurrencyPickerNavigatorVCRouter: BaseRouter {

    func makeCurrencyPicker(disabledCurrencyFrom: CurrencyModel? = nil, delegate: CurrencyPickerOutput) -> UIViewController {
        moduleAssemble.makePicker(disabledCurrencyFrom: disabledCurrencyFrom, delegate: delegate)
    }

    func pushCurrencyPicker(disabledCurrencyFrom: CurrencyModel?, delegate: CurrencyPickerOutput) {
        let vc = makeCurrencyPicker(disabledCurrencyFrom: disabledCurrencyFrom, delegate: delegate)
        push(vc: vc)
    }
}
