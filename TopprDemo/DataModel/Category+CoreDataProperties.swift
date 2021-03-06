//
//  Category+CoreDataProperties.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var products: NSSet?
    @NSManaged public var childCategories: NSSet?

}

// MARK: Generated accessors for products
extension Category {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

// MARK: Generated accessors for childCategories
extension Category {

    @objc(addChildCategoriesObject:)
    @NSManaged public func addToChildCategories(_ value: ChildCategory)

    @objc(removeChildCategoriesObject:)
    @NSManaged public func removeFromChildCategories(_ value: ChildCategory)

    @objc(addChildCategories:)
    @NSManaged public func addToChildCategories(_ values: NSSet)

    @objc(removeChildCategories:)
    @NSManaged public func removeFromChildCategories(_ values: NSSet)

}
