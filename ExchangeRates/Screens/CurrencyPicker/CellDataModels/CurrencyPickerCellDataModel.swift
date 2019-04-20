//
//  CurrencyPickerCellDataModel.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

final class CurrencyPickerCellDataModel: BaseTableCellData {

    enum DataType {
        case listItem(currency: CurrencyModel, isActive: Bool)

        func dequeueReusableCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
            switch self {
            case .listItem(let currency, let isActive):
                let CellReuseIdentifier = CurrencyPickerListItemCell.ReuseIdentifier
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: CellReuseIdentifier,
                    for: indexPath
                ) as? CurrencyPickerListItemCell
                cell?.setup(currency: currency, isActive: isActive)
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
            CurrencyPickerListItemCell.Nib,
            forCellReuseIdentifier: CurrencyPickerListItemCell.ReuseIdentifier
        )
    }
}
