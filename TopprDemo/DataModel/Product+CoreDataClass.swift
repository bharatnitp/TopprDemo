//
//  Product+CoreDataClass.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject {
    class func createProduct(model: ProductModel) -> Product {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let product = Product(context: context)
        product.id = Int64(model.id)
        product.name = model.name
        product.dateAdded = model.dateAdded
        product.tax = Tax.createTax(model: model.tax)
        
        let variants = model.variants?.map({ (variantModel) -> Variant in
            return Variant.createVariant(model: variantModel)
        })
        product.addToVariants(NSSet(array: variants ?? []))
        return product
    }
    
    class func getProduct(with id: Int64) -> Product? {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        
        do {
            let products = try context.fetch(fetchRequest)
            if products.count > 0 {
                return products.first
            }
            return nil
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
