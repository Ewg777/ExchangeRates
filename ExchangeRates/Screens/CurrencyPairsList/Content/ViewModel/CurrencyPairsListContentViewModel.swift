//
//  CurrencyPairsListContentViewModel.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

final class CurrencyPairsListContentViewModel: BaseTableViewModel {

    private weak var view: CurrencyPairsListContentInput?
    private let router: CurrencyPairsListContentVCRouter
    private let cellsBuilder: CurrencyPairsListContentCellsBuilder
    private let dataManager: CurrencyPairsListContentDataManager
    private let ratesUpdaterService: RatesUpdaterServiceProtocol
    private let listContainerDelegate: CurrencyPairsListOutput
    private let currencyPairs: [CurrencyPairModel]

    init(
        view: CurrencyPairsListContentInput,
        router: CurrencyPairsListContentVCRouter,
        cellsBuilder: CurrencyPairsListContentCellsBuilder,
        dataManager: CurrencyPairsListContentDataManager,
        ratesUpdaterService: RatesUpdaterService,
        listContainerDelegate: CurrencyPairsListOutput,
        currencyPairs: [CurrencyPairModel]
    ) {
        self.view = view
        self.router = router
        self.cellsBuilder = cellsBuilder
        self.dataManager = dataManager
        self.ratesUpdaterService = ratesUpdaterService
        self.listContainerDelegate = listContainerDelegate
        self.currencyPairs = currencyPairs
    }

    func didLoad() {
        ratesUpdaterService.setup(currencyPairs: currencyPairs)
    }

    func willAppear() {
        ratesUpdaterService.start { [weak self] rates in
            DispatchQueue.main.async { [weak self] in
                self?.bind(rates: rates)
            }
        }
    }

    func willDisappear() {
        ratesUpdaterService.stop()
    }

    func didSelectAddNew() {
        listContainerDelegate.pairsList(self, onAddCurrencyPairTap: nil)
    }

    func didSelect(rateItem rate: CurrencyRateModel) {
        let title = NSLocalizedString("Delete?", comment: "")
        let message = NSLocalizedString("Would you like to delete pair \(rate.humanReadable)?", comment: "")
        router.showAlert(
            title: title,
            message: message,
            onConfirmBlock: { [weak self] in
                guard let `self` = self else { return }
                self.listContainerDelegate.pairsList(self, deleteCurrencyPair: rate.toPairModel())
        })
    }

    private func bind(rates: [CurrencyRateModel]) {
        let list = cellsBuilder.makeList(currencyRates: rates)
        dataManager.update(newCells: list)
        view?.reload()
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension CurrencyPairsListContentViewModel: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataManager.cells[indexPath.row]
        let cell = data.dequeueReusableCell(tableView, indexPath: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let data = dataManager.cells[indexPath.row]

        switch data.type {
        case .addNew:
            didSelectAddNew()
        case .rateItem(let rate):
            didSelect(rateItem: rate)
        }
    }
}

private extension CurrencyRateModel {
    var humanReadable: String { "\(from.currency.code)-\(to.currency.code)" }
}
