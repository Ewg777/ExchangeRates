//
//  CurrencyPickerListItemCell.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

final class CurrencyPickerListItemCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    func setup(currency: CurrencyModel, isActive: Bool) {
        setup(currency: currency)
        setup(isActive: isActive)
    }

    func setup(currency: CurrencyModel) {
        flagImageView.image = currency.getCountryFlagImage()
        currencyCodeLabel.text = currency.code
        titleLabel.text = currency.title
    }

    func setup(isActive: Bool) {
        isUserInteractionEnabled = isActive
        contentView.alpha = isActive ? 1 : 0.3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        currencyCodeLabel.font = selected ? .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 16)
        titleLabel.font = selected ? .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 16)
    }
}
