//
//  APIServiceError.swift
//  ExchangeRates
//
//  Created by Ewg on 21.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//
enum APIServiceError: Error {
    case apiError(String)
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}
