//
//  BaseRouter.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

class BaseRouter {
    let moduleAssemble: CurrencyModuleAssembleProtocol
    
    private weak var viewController: UIViewController?

    init(vc: UIViewController, moduleAssemble: CurrencyModuleAssembleProtocol) {
        viewController = vc
        self.moduleAssemble = moduleAssemble
    }

    func push(vc: UIViewController, animated: Bool = true) {
        viewController?.navigationController?.pushViewController(vc, animated: animated)
    }

    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }

    func present(vc: UIViewController) {
        viewController?.present(vc, animated: true, completion: nil)
    }
}
