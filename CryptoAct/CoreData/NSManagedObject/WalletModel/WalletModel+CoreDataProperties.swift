//
//  WalletModel+CoreDataProperties.swift
//  CryptoBalance
//
//  Created by Serj on 05.02.2023.
//
//

import Foundation
import CoreData


extension WalletModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WalletModel> {
        return NSFetchRequest<WalletModel>(entityName: "WalletModel")
    }
    
    
    @NSManaged var network: String?
    @NSManaged var balance: String?
    @NSManaged var address: String?
    @NSManaged var dateSort: Date?
    @NSManaged var finalNTX: String?
    
    

    
}

extension WalletModel: Identifiable {

}
