//
//  CurrencyPairsListEmptyAssemble.swift
//  ExchangeRates
//
//  Created by Ewg on 21.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import UIKit

protocol CurrencyPairsListEmptyAssembleProtocol: CurrencyModuleBaseAssembleProtocol {

    func assemble(delegate: CurrencyPairsListOutput) -> UIViewController
}

final class CurrencyPairsListEmptyAssemble: CurrencyModuleBaseAssemble {
}

extension CurrencyPairsListEmptyAssemble: CurrencyPairsListEmptyAssembleProtocol {

    func assemble(delegate: CurrencyPairsListOutput) -> UIViewController {
        let vc = CurrencyPairsListEmptyVC.Create(delegate: delegate) ?? UIViewController()//Todo: fix me!!!

        return vc
    }
}


