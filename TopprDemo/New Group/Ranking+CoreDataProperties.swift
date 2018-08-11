//
//  Ranking+CoreDataProperties.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData


extension Ranking {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ranking> {
        return NSFetchRequest<Ranking>(entityName: "Ranking")
    }

    @NSManaged public var rank: String
    @NSManaged public var productMetaData: NSSet?

}

// MARK: Generated accessors for productMetaData
extension Ranking {

    @objc(addProductMetaDataObject:)
    @NSManaged public func addToProductMetaData(_ value: ProductMetaData)

    @objc(removeProductMetaDataObject:)
    @NSManaged public func removeFromProductMetaData(_ value: ProductMetaData)

    @objc(addProductMetaData:)
    @NSManaged public func addToProductMetaData(_ values: NSSet)

    @objc(removeProductMetaData:)
    @NSManaged public func removeFromProductMetaData(_ values: NSSet)

}
