//
//  URLSessionExtensions.swift
//  ExchangeRates
//
//  Created by Ewg on 21.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    var isSuccess: Bool { 200..<299 ~= statusCode }
}

extension URLSession {
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void
    ) -> URLSessionDataTask {
        return dataTask(with: url, completionHandler: { (data, urlResponse, error) in
            if let error = error {
                completionHandler(.failure(error))
            } else if let data = data, let urlResponse = urlResponse as? HTTPURLResponse {
                completionHandler(.success((data, urlResponse)))
            }
        })
    }
}
