//
//  IdTtransactions+CoreDataProperties.swift
//  CryptoBalance
//
//  Created by Serj on 05.04.2023.
//
//

import Foundation
import CoreData


extension IdTtransactions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IdTtransactions> {
        return NSFetchRequest<IdTtransactions>(entityName: "IdTtransactions")
    }

    @NSManaged public var idTtransaction: String?

}

extension IdTtransactions : Identifiable {

}
