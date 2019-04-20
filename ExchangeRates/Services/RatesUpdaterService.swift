//
//  RatesUpdaterService.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 21/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation

protocol RatesUpdaterServiceProtocol: AnyObject {
    typealias RatesBlock = ((_ rates: [CurrencyRateModel]) -> Void)

    func setup(currencyPairs: [CurrencyPairModel])

    func start(successBlock: @escaping RatesBlock)

    func stop()
}

final class RatesUpdaterService {

    private let UpdateInterval: Double = 1

    private let apiRatesService: ApiRatesServiceProtocol

    private var successBlock: RatesBlock?

    private weak var updateTimer: Timer?
    private var selectedCurrencyPairs: [CurrencyPairModel] = []

    init(apiRatesService: ApiRatesServiceProtocol) {
        self.apiRatesService = apiRatesService
    }

    @objc private func run() {
        apiRatesService.fetch(pairs: selectedCurrencyPairs) { [weak self] rates in
            self?.successBlock?(rates)
        }
    }
}

extension RatesUpdaterService: RatesUpdaterServiceProtocol {
    func start(successBlock: @escaping RatesBlock) {
        stop()

        self.successBlock = successBlock

        updateTimer = Timer.scheduledTimer(
            timeInterval: UpdateInterval,
            target: self,
            selector: #selector(run),
            userInfo: nil,
            repeats: true
        )

    }

    func stop() {
        successBlock = nil

        updateTimer?.invalidate()
        updateTimer = nil
    }

    func setup(currencyPairs: [CurrencyPairModel]) {
        selectedCurrencyPairs = currencyPairs
    }
}
