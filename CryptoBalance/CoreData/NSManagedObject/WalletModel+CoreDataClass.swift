//
//  WalletModel+CoreDataClass.swift
//  CryptoBalance
//
//  Created by Serj on 05.02.2023.
//
//

import Foundation
import CoreData

@objc(WalletModel)
public class WalletModel: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityName(name: "WalletModel"), insertInto: CoreDataManager.shared.context)
    }
}
