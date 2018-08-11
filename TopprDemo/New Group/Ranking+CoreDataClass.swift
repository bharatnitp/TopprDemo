//
//  Ranking+CoreDataClass.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Ranking)
public class Ranking: NSManagedObject {
    class func createRanking(model: RankingModel) {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let ranking = Ranking(context: context)
        ranking.rank = model.ranking
        let metaData = model.products.map { (metaData) -> ProductMetaData in
            return ProductMetaData.createProductMetaData(model: metaData)
        }
        ranking.addToProductMetaData(NSSet(array: metaData))
    }
    
    class func fetchAllRankings() -> [Ranking]? {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Ranking> = Ranking.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    class func reset() {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Ranking")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
        } catch {
            print (error.localizedDescription)
        }
    }
}
