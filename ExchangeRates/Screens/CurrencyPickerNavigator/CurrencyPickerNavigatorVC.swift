//
//  CurrencyPickerNavigatorVC.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

protocol CurrencyPickerNavigatorInput: AnyObject {
    func addChild(vc: UIViewController)
}

protocol CurrencyPickerNavigatorOutput: AnyObject {
    func currencyPickerNavigator(_ sender: Any, didSelectPair pair: CurrencyPairModel)
}

final class CurrencyPickerNavigatorVC: UIViewController {
    typealias Delegate = CurrencyPickerNavigatorOutput

    fileprivate var activeVC: UIViewController?

    fileprivate var viewModel: CurrencyPickerNavigatorViewModel?

    func setup(viewModel: CurrencyPickerNavigatorViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.didLoad()
    }
}

extension CurrencyPickerNavigatorVC: CurrencyPickerNavigatorInput {
    func addChild(vc: UIViewController) {
        add(child: vc)
        activeVC = vc
    }
}
