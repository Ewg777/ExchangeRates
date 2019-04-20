//
//  CurrencyPickerNavigatorViewModel.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation

final class CurrencyPickerNavigatorViewModel {

    private weak var view: CurrencyPickerNavigatorInput?
    private let router: CurrencyPickerNavigatorVCRouter
    private let output: CurrencyPickerNavigatorOutput
    private let storageService: SelectedPairStorageServiceProtocol

    var currencyFrom: CurrencyModel?

    init(
        view: CurrencyPickerNavigatorInput,
        router: CurrencyPickerNavigatorVCRouter,
        output: CurrencyPickerNavigatorOutput,
        storageService: SelectedPairStorageServiceProtocol
    ) {
        self.view = view
        self.router = router
        self.output = output
        self.storageService = storageService
    }

    func didLoad() {
        // Shows picker as a child view controller for the first step
        let newVC = router.makeCurrencyPicker(delegate: self)
        view?.addChild(vc: newVC)
    }
}

// MARK: - CurrencyPickerDelegate
extension CurrencyPickerNavigatorViewModel: CurrencyPickerOutput {

    func currencyPicker(_ sender: Any, didSelectCurrency currency: CurrencyModel) {
        guard let currencyFrom = currencyFrom else {
            // Shows picker as a view controller pushed in the navitation controller for the second step
            self.currencyFrom = currency
            router.pushCurrencyPicker(disabledCurrencyFrom: currency, delegate: self)
            return
        }
        
        let pair = CurrencyPairModel(currencyFrom: currencyFrom, currencyTo: currency)
        storageService.saveSync(pair: pair)
        router.dismiss()
        output.currencyPickerNavigator(self, didSelectPair: pair)
    }
}
