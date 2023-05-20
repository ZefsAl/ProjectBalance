//
//  IdTtransactions+CoreDataClass.swift
//  CryptoBalance
//
//  Created by Serj on 05.04.2023.
//
//

import Foundation
import CoreData

@objc(IdTtransactions)
public class IdTtransactions: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataManager.shared.entityName(name: "IdTtransactions"), insertInto: CoreDataManager.shared.context)
    }
    
}
