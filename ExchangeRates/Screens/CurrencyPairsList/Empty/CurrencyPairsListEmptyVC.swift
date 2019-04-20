//
//  CurrencyPairsListEmptyVC.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit


final class CurrencyPairsListEmptyVC: UIViewController {
    typealias Delegate = CurrencyPairsListOutput

    fileprivate weak var delegate: Delegate?

    static func Create(delegate: Delegate) -> UIViewController? {
        //TODO: Migrate to code layout
        let vc = UIStoryboard(name: "CurrencyPairsListEmpty", bundle: nil)
            .instantiateInitialViewController() as? CurrencyPairsListEmptyVC
        vc?.delegate = delegate
        return vc
    }

    @IBAction func onAddCurrencyTap(_ sender: Any) {
        delegate?.pairsList(self, onAddCurrencyPairTap: nil)
    }
}
