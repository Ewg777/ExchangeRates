//
//  CurrencyPairsListContentRateItemCell.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

final class CurrencyPairsListContentRateItemCell: UITableViewCell {

    @IBOutlet weak var titleFromLabel: UILabel!
    @IBOutlet weak var subtitleFromLabel: UILabel!

    @IBOutlet weak var titleToLabel: UILabel!
    @IBOutlet weak var subtitleToLabel: UILabel!

    func setup(rate: CurrencyRateModel) {
        titleFromLabel.text = rate.from.formatedAmountCurrency()
        subtitleFromLabel.text = rate.from.currency.title
        titleToLabel.text = rate.to.formatedAmountRate() ?? "Unable to load rate"
        subtitleToLabel.text = rate.to.currency.formatedTitle()
    }
}
