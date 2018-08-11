//
//  Variant+CoreDataProperties.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData


extension Variant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Variant> {
        return NSFetchRequest<Variant>(entityName: "Variant")
    }

    @NSManaged public var id: Int64
    @NSManaged public var color: String?
    @NSManaged public var size: Int64
    @NSManaged public var price: Float
    @NSManaged public var product: Product?

}
