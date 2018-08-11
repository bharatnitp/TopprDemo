//
//  ChildCategory+CoreDataClass.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ChildCategory)
public class ChildCategory: NSManagedObject {

    class func createChildCategory(id: Int) -> ChildCategory {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let childCategory = ChildCategory(context: context)
        childCategory.id = Int64(id)
        return childCategory
    }
}
