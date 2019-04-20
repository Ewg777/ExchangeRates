//
//  ConfigContainer.swift
//  ExchangeRates
//
//  Created by Ewg on 21.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import Foundation

struct ConfigContainer {
    let currenciesInfoConfig: CurrenciesInfoConfig

    let apiEndPointURL = URLComponents(string: "https://api.jsonbin.io/b/5ef87d15bb5fbb1d256032d8")!
}
