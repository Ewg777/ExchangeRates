//
//  CurrencyPickerViewModel.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

final class CurrencyPickerViewModel: BaseTableViewModel {
    weak var view: CurrencyPickerInput?
    let cellsBuilder: CurrencyPickerCellsBuilderProtocol
    let dataManager: CurrencyPickerDataManagerProtocol
    let storageService: SelectedPairStorageServiceProtocol
    weak var output: CurrencyPickerOutput?
    let disabledCurrencyFrom: CurrencyModel?

    init(
        view: CurrencyPickerInput,
        cellsBuilder: CurrencyPickerCellsBuilderProtocol,
        dataManager: CurrencyPickerDataManagerProtocol,
        storageService: SelectedPairStorageServiceProtocol,
        output: CurrencyPickerOutput,
        disabledCurrencyFrom: CurrencyModel?
    ) {
        self.view = view
        self.cellsBuilder = cellsBuilder
        self.dataManager = dataManager
        self.storageService = storageService
        self.output = output
        self.disabledCurrencyFrom = disabledCurrencyFrom
    }

    func didLoad() {
        let allCurrencies = fetchAllCurrencies()
        let disabledCurrencies = fetchDisabledCurrencies()
        let list = cellsBuilder.makeList(allCurrencies, disabledCurrencies: disabledCurrencies)
        dataManager.update(newCells: list)
        view?.reloadTable()
    }

    private func fetchAllCurrencies() -> [CurrencyModel] {
        storageService.getAllCurrencies()
    }

    private func fetchDisabledCurrencies() -> [CurrencyModel] {
        var result: [CurrencyModel] = []
        guard let disabledCurrencyFrom = disabledCurrencyFrom else { return result }

        result.append(disabledCurrencyFrom)

        let currencyToDisabled = storageService
            .getAllPairsSync(from: disabledCurrencyFrom)?
            .compactMap({ $0.currencyTo })

        if let currencyToDisabled = currencyToDisabled {
            result.append(contentsOf: currencyToDisabled)
        }
        
        return result
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension CurrencyPickerViewModel: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataManager.cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataManager.cells[indexPath.row]
        let cell = data.dequeueReusableCell(tableView, indexPath: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataManager.cells[indexPath.row]

        switch data.type {
        case .listItem(let currency, _):
            output?.currencyPicker(self, didSelectCurrency: currency)
        }
    }
}
