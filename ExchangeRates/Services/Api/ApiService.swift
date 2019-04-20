//
//  ApiService.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import Foundation

protocol ApiServiceProtocol: AnyObject {
    associatedtype Model: Decodable
    typealias RequestResult = Result<Model, APIServiceError>

    func fetch(url: URL, completion: @escaping (RequestResult) -> Void)
}

class ApiService<Model: Decodable> {
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder

    required init(urlSession: URLSession, jsonDecoder: JSONDecoder = .init()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
}

extension ApiService: ApiServiceProtocol {

    func fetch(url: URL, completion: @escaping (Result<Model, APIServiceError>) -> Void) {
        urlSession.dataTask(with: url) { (result) in
            switch result {
                case .success(let (data, response)):
                    guard response.isSuccess == true else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    do {
                        let values = try self.jsonDecoder.decode(Model.self, from: data)
                        completion(.success(values))
                    } catch {
                        completion(.failure(.decodeError))
                    }
                case .failure(let error):
                    completion(.failure(.apiError(error.localizedDescription)))
                }
         }.resume()
    }
}
