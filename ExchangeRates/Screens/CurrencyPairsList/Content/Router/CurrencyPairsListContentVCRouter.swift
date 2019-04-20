//
//  CurrencyPairsListContentVCRouter.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 21/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

final class CurrencyPairsListContentVCRouter: BaseRouter {

    func showAlert(title: String,
                   message: String,
                   onConfirmBlock: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let actionYes = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default) { _ in
            onConfirmBlock()
        }

        let actionCancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { (action:UIAlertAction) in

        }

        alertController.addAction(actionYes)
        alertController.addAction(actionCancel)
        present(vc: alertController)
    }
}
