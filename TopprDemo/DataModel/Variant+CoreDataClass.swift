//
//  Variant+CoreDataClass.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Variant)
public class Variant: NSManagedObject {
    class func createVariant(model: VariantModel) -> Variant {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let variant = Variant(context: context)
        variant.id = Int64(model.id)
        variant.price = model.price
        variant.size = Int64(model.size ?? 0)
        variant.color = model.color
        return variant
    }
}
