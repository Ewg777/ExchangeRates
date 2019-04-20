//
//  CurrencyModuleBaseAssemble.swift
//  ExchangeRates
//
//  Created by Ewg on 21.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import Foundation

protocol CurrencyModuleBaseAssembleProtocol: AnyObject {
    var moduleAssemble: CurrencyModuleAssembleProtocol { get }
}

class CurrencyModuleBaseAssemble: CurrencyModuleBaseAssembleProtocol {
    let moduleAssemble: CurrencyModuleAssembleProtocol

    init(moduleAssemble: CurrencyModuleAssembleProtocol) {
        self.moduleAssemble = moduleAssemble
    }
}
