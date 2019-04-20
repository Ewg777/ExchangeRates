//
//  ConfigLoader.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation

protocol ConfigLoaderProtocol: AnyObject {
    var config: ConfigContainer { get }
}

final class ConfigLoader: ConfigLoaderProtocol {
    lazy var config: ConfigContainer = {
        guard let currenciesInfo = loadCurrenciesInfo() else {
            fatalError("Unable to load configuration. Please check the resources")
        }
        return ConfigContainer(currenciesInfoConfig: currenciesInfo)
    }()

    private let decoder: JSONDecoder

    private enum Resource: String {
        case currencyInfo = "currencies"
    }

    init(decoder: JSONDecoder = .init()) {
        self.decoder = decoder
    }
}

extension ConfigLoader {

    private func loadCurrenciesInfo() -> CurrenciesInfoConfig? {
        decode(resource: .currencyInfo)
    }
}

extension ConfigLoader {

    private func decode<T: Decodable>(resource: Resource) -> T? {
        guard
            let url = makeUrl(for: resource),
            let data = try? Data(contentsOf: url, options: .alwaysMapped) else {
            return nil
        }


        return try? decoder.decode(T.self, from: data)
    }

    private func makeUrl(for resource: Resource) -> URL? {
        Bundle.main.url(forResource: resource.rawValue, withExtension: "json")
    }
}
