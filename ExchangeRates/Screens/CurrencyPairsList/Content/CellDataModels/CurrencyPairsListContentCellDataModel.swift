//
//  CurrencyPairsListContentCellDataModel.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

final class CurrencyPairsListContentCellDataModel: BaseTableCellData {

    enum DataType {
        case rateItem(rate: CurrencyRateModel)
        case addNew

        func dequeueReusableCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
            switch self {
            case .rateItem(let rate):
                let CellReuseIdentifier = CurrencyPairsListContentRateItemCell.ReuseIdentifier
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: CellReuseIdentifier,
                    for: indexPath
                ) as? CurrencyPairsListContentRateItemCell
                cell?.setup(rate: rate)
                return cell
            case .addNew:
                let CellReuseIdentifier = CurrencyPairsListContentAddNewCell.ReuseIdentifier
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: CellReuseIdentifier,
                    for: indexPath
                ) as? CurrencyPairsListContentAddNewCell
                return cell
            }
        }
    }

    let type: DataType

    init(type: DataType) {
        self.type = type
    }

    func dequeueReusableCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        type.dequeueReusableCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }

    static func registerCells(tableView: UITableView) {
        tableView.register(
            CurrencyPairsListContentRateItemCell.Nib,
            forCellReuseIdentifier: CurrencyPairsListContentRateItemCell.ReuseIdentifier
        )
        tableView.register(
            CurrencyPairsListContentAddNewCell.Nib,
            forCellReuseIdentifier: CurrencyPairsListContentAddNewCell.ReuseIdentifier
        )
    }
}
