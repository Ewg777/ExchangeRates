//
//  CurrencyPairsListVC.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

protocol CurrencyPairsListOutput: AnyObject {
    func pairsList(_ sender: Any, onAddCurrencyPairTap: Any?)
    func pairsList(_ sender: Any, deleteCurrencyPair pair: CurrencyPairModel)
}

protocol CurrencyPairsListViewInput: AnyObject {

    func updateChild(with vc: UIViewController)
}

final class CurrencyPairsListVC: UIViewController {

    // MARK: -
    var activeVC: UIViewController?

    private var viewModel: CurrencyPairsListViewModel?

    func setup(viewModel: CurrencyPairsListViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.didLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel?.willAppear()
    }
}

// MARK: - CurrencyPairsListViewInput
extension CurrencyPairsListVC: CurrencyPairsListViewInput {

    func updateChild(with vc: UIViewController) {
        activeVC?.removeChild()
        activeVC = nil
        add(child: vc)
        activeVC = vc
    }
}
