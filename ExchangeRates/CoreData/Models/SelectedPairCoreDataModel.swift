//
//  SelectedPairCoreDataModel.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import CoreData

final class SelectedPairCoreDataModel: NSManagedObject, CoreDataModelProtocol {

    static var entryName: String { "SelectedPairCoreDataModel" }
}

extension SelectedPairCoreDataModel {

    @NSManaged var currencyCodeFrom: String
    @NSManaged var currencyCodeTo: String
}


