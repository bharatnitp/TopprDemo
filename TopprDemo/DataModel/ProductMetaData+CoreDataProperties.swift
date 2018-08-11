//
//  ProductMetaData+CoreDataProperties.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductMetaData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductMetaData> {
        return NSFetchRequest<ProductMetaData>(entityName: "ProductMetaData")
    }

    @NSManaged public var id: Int64
    @NSManaged public var rankingCriteriaKey: String?
    @NSManaged public var rankingCriteriaValue: Int64
    @NSManaged public var ranking: Ranking?

}
