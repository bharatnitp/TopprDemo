//
//  ProductMetaData+CoreDataClass.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ProductMetaData)
public class ProductMetaData: NSManagedObject {
    class func createProductMetaData(model: [String: Int]) -> ProductMetaData {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let metaData = ProductMetaData(context: context)
        metaData.id = Int64(model["id"] ?? 0)
        let keys = model.keys.map { $0 }
        if keys.count > 1 {
            metaData.rankingCriteriaKey = keys[1]
            metaData.rankingCriteriaValue = Int64(model[keys[1]] ?? 0)
        }
        return metaData
    }
}
