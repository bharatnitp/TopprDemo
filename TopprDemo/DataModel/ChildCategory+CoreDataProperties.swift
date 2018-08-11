//
//  ChildCategory+CoreDataProperties.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData


extension ChildCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChildCategory> {
        return NSFetchRequest<ChildCategory>(entityName: "ChildCategory")
    }

    @NSManaged public var id: Int64
    @NSManaged public var category: NSSet?

}

// MARK: Generated accessors for category
extension ChildCategory {

    @objc(addCategoryObject:)
    @NSManaged public func addToCategory(_ value: Category)

    @objc(removeCategoryObject:)
    @NSManaged public func removeFromCategory(_ value: Category)

    @objc(addCategory:)
    @NSManaged public func addToCategory(_ values: NSSet)

    @objc(removeCategory:)
    @NSManaged public func removeFromCategory(_ values: NSSet)

}
