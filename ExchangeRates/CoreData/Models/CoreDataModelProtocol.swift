//
//  CoreDataModelProtocol.swift
//  ExchangeRates
//
//  Created by Ewg on 24.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import CoreData

protocol CoreDataModelProtocol: NSManagedObject {

    static var entryName: String { get }

}
