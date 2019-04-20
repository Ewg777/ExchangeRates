//
//  CurrencyModel.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

struct CurrencyModel: Codable {
    let code: String
    let title: String
    let countryISOCode: String
    let countryFlag: String?
}

extension CurrencyModel {

    func formatedTitle() -> String {
        title + " " + code
    }

    func getCountryFlagImage() -> UIImage? {
        guard let countryFlag = countryFlag else { return nil }

        return UIImage(named: countryFlag)
    }
}

// MARK: - Equatable
extension CurrencyModel: Equatable {
    static func == (lhs: CurrencyModel, rhs: CurrencyModel) -> Bool {
        return lhs.code == rhs.code
    }
}

// MARK: - Array
extension Array where Element == CurrencyModel {

    func get(byCode code: String) -> Element? {
        return filter { $0.code == code }.first
    }
}

