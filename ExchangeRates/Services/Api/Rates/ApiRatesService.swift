//
//  ApiRatesService.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation


protocol ApiRatesServiceProtocol: AnyObject {
    typealias SuccessResult = [CurrencyRateModel]

    func fetch(pairs: [CurrencyPairModel], completion: @escaping (SuccessResult) -> Void)
}

final class ApiRatesService {
    private let apiService: ApiRatesServicePrivate // TODO: Isolate it!
    private let mapper: ApiRatesMapperProtocol
    private let baseURL: URLComponents

    init(
        urlSession: URLSession,
        mapper: ApiRatesMapperProtocol,
        baseURL: URLComponents
    ) {
        self.apiService = ApiRatesServicePrivate(urlSession: urlSession)
        self.mapper = mapper
        self.baseURL = baseURL
    }
}

extension ApiRatesService: ApiRatesServiceProtocol {
    func fetch(pairs: [CurrencyPairModel], completion: @escaping (SuccessResult) -> Void) {
        var urlComp = baseURL
        let queryItems = pairs.map { URLQueryItem(name: "pairs", value: $0.toQuery()) }
        urlComp.queryItems = queryItems

        guard let url = urlComp.url else { return }
        apiService.fetch(url: url, completion: { result in
            switch result {
            case .success(let model):
                let rates = self.mapper.mapToRates(pairs: pairs, from: model)
                completion(rates)
                break
            case .failure(let error):
//            completion(rates)//TODO:!!!
            break

            }
        })
    }
}

private typealias Model = Dictionary<String, Double>
private final class ApiRatesServicePrivate: ApiService<Model> {

}
