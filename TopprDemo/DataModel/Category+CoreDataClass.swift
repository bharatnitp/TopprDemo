//
//  Category+CoreDataClass.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject {

    class func createCategory(model: CategoryModel) {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let category = Category(context: context)
        category.id = Int64(model.id)
        category.name = model.name
        let products = model.products.map { (product) -> Product in
            let product = Product.createProduct(model: product)
            product.category = category
            return product
        }
        
        let childCategories = model.childCategories?.map { (categoryId) -> ChildCategory in
            let childCategory = ChildCategory.createChildCategory(id: categoryId)
            category.addToChildCategories(childCategory)
            return childCategory
        }
        category.addToProducts(NSSet(array: products))
        category.addToChildCategories(NSSet(array: childCategories ?? []))
    }
    
    class func fetchAllCategories() -> [Category]? {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    class func reset() {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
        } catch {
            print (error.localizedDescription)
        }
    }
}
