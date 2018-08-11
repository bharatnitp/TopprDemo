//
//  Tax+CoreDataClass.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Tax)
public class Tax: NSManagedObject {
    class func createTax(model: TaxModel) -> Tax {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let tax = Tax(context: context)
        tax.name = model.name
        tax.value = model.value ?? 0.0
        return tax
    }
}
