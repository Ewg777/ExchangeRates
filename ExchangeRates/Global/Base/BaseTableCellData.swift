//
//  BaseTableCellData.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

protocol BaseTableCellData {

    static func registerCells(tableView: UITableView)

    func dequeueReusableCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
