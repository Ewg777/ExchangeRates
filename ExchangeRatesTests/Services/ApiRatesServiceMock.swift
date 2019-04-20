//
//  ApiRatesServiceMock.swift
//  ExchangeRatesTests
//
//  Created by Ewg on 27.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import Foundation

@testable import ExchangeRates

final class ApiRatesServiceMock: ApiRatesServiceProtocol {

    private var result: SuccessResult = []

    init(result: SuccessResult) {
        self.result = result
    }

    init(urlSession: URLSession, mapper: ApiRatesMapperProtocol) {}

    func fetch(pairs: [CurrencyPairModel], completion: @escaping (SuccessResult) -> Void) {
        completion(result)
    }
}
