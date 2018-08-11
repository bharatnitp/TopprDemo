//
//  Tax+CoreDataProperties.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData


extension Tax {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tax> {
        return NSFetchRequest<Tax>(entityName: "Tax")
    }

    @NSManaged public var name: String?
    @NSManaged public var value: Float
    @NSManaged public var product: Product?

}
