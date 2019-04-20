//
//  CoreDataFacade.swift
//  ExchangeRates
//
//  Created by Ewg on 21.06.2020.
//  Copyright © 2020 Just For Fun. All rights reserved.
//

import CoreData

protocol CoreDataFacadeProtocol: AnyObject {
    
    func createSync<M: CoreDataModelProtocol>() -> M?

    func fetchSync<M: CoreDataModelProtocol>(predicate: NSPredicate?) -> [M]?

    func fetchSync<M: CoreDataModelProtocol>(_ request: NSFetchRequest<NSFetchRequestResult>) -> [M]?
    
    func deleteSync(_ objects: [NSManagedObject])
}

final class CoreDataFacade: CoreDataFacadeProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func deleteSync(_ objects: [NSManagedObject]) {
        objects.forEach { context.delete($0) }
    }

    func fetchSync<M: CoreDataModelProtocol>(predicate: NSPredicate?) -> [M]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: M.entryName)
        fetchRequest.predicate = predicate
        return fetchSync(fetchRequest)
    }

    func fetchSync<M: CoreDataModelProtocol>(_ request: NSFetchRequest<NSFetchRequestResult>) -> [M]? {
        try? context.fetch(request) as? [M]
    }

    func createSync<M: CoreDataModelProtocol>() -> M? {
        NSEntityDescription.insertNewObject(forEntityName: M.entryName, into: context) as? M
    }
}
