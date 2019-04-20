//
//  CurrencyPairsListViewModel.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

final class CurrencyPairsListViewModel {
    private weak var view: CurrencyPairsListViewInput?
    private var router: CurrencyPairsListVCRouter
    private let storageService: SelectedPairStorageServiceProtocol

    private enum ViewState {
        case empty, content(currencyPairs: [CurrencyPairModel])
    }

    init(
        view: CurrencyPairsListViewInput,
        router: CurrencyPairsListVCRouter,
        storageService: SelectedPairStorageServiceProtocol
    ) {
        self.view = view
        self.router = router
        self.storageService = storageService
    }

    func didLoad() {
        
    }

    func willAppear() {
        fetchDataAndUpdateView()
    }
    // MARK: - Private

    private func fetchDataAndUpdateView() {
        guard
            let pairs = storageService.getAllPairsSync(),
            !pairs.isEmpty else {
                update(viewState: .empty)
                return
        }
        update(viewState: .content(currencyPairs: pairs))
    }

    private func update(viewState: ViewState) {
        let newVC = makeNewVC(with: viewState)
        view?.updateChild(with: newVC)
    }

    private func makeNewVC(with viewState: ViewState) -> UIViewController {
        switch viewState {
        case .empty:
            return router.makeEmpty(delegate: self)
        case .content(let currencyPairs):
            return router.makeContent(pairs: currencyPairs, listContainerDelegate: self)
        }
    }
}

// MARK: - CurrencyPickerNavigatorOutput
extension CurrencyPairsListViewModel: CurrencyPickerNavigatorOutput {
    func currencyPickerNavigator(_ sender: Any, didSelectPair pair: CurrencyPairModel) {
        fetchDataAndUpdateView()
    }
}

// MARK: - CurrencyPairsListEmptyDelegate
extension CurrencyPairsListViewModel: CurrencyPairsListOutput {

    func pairsList(_ sender: Any, onAddCurrencyPairTap: Any?) {
        router.showCurrencyPickerNavigator(delegate: self)
    }

    func pairsList(_ sender: Any, deleteCurrencyPair pair: CurrencyPairModel) {
        storageService.deleteSync(pair: pair)

        fetchDataAndUpdateView()
    }
}
