//
//  MainViewModel.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//

import Foundation
import CoreData

enum SectionType {
    case category
    case ranking
}

protocol HomeViewModelDelegate: class {
    func didReceiveData()
    func didReceiveError()
}

class HomeViewModel {
    
    private(set) var categories: [Category]
    private(set) var rankings: [Ranking]
    private(set) var sections: [(sectionType: SectionType, expanded: Bool)] = [(sectionType: SectionType, expanded: Bool)]()
    
    let interactor: WebServiceInteractor
    weak var delegate: HomeViewModelDelegate?
    
    //MARK :- initializer method
    
    init(delegate: HomeViewModelDelegate) {
        interactor = WebServiceInteractor()
        self.delegate = delegate
        self.categories = [Category]()
        self.rankings =  [Ranking]()
        getData()
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        
        let section = sections[section]
        if section.expanded == false { return  0 }
        
        if section.sectionType == .category {
            return categories.count
        } else if section.sectionType == .ranking {
            return rankings.count
        }
        return 0
    }
    
    func itemForRow(in section: Int, at index: Int) -> Any? {
        let section = sections[section]
        if section.sectionType == .category {
            return categories[index]
        } else if section.sectionType == .ranking {
            return rankings[index]
        }
        return nil
    }
    
    func titleForHeader(in section: Int) -> String {
        var titleText = ""
        let section = sections[section]
        if section.sectionType == .category {
            titleText = "Select Product By Category"
        } else if section.sectionType == .ranking {
            titleText = "Select Product By Ranking"
        }
        return titleText
    }
    
    func toggleSection(shouldExpand: Bool, _ section: Int) {
        let _section = sections[section]
        sections[section] = (_section.sectionType, shouldExpand)
    }
    
    func getProducts(_ _section: Int, _ row: Int) -> [Product]? {
        let section = sections[_section]
        if section.sectionType == .category, let products = (categories[row].products?.allObjects as? [Product]), products.count > 0 {
            return products
        } else if section.sectionType == .ranking {
            if let productMetaData = rankings[row].productMetaData?.allObjects as? [ProductMetaData], productMetaData.count > 0 {
                let ids = productMetaData.map { $0.id }
                let products = ids.compactMap({ (id) -> Product? in
                    return Product.getProduct(with: id)
                })
                
                return products
            }
        }
        return nil
    }
    
    func getData() {
        interactor.getData(completion: {[weak self] (response) in
            
            guard let weakSelf = self else { return }
            switch response {
            case .success(let response):
                if let response = response {
                    weakSelf.saveResponseToCoreData(response: response)
                }
            case .failure(let error):
                weakSelf.delegate?.didReceiveError()
                print(error.localizedDescription)
            }
        })
    }

    func saveResponseToCoreData(response: ResponseModel) {
        //Clear every thing from coreData
        CoreDataManager.sharedInstance.reset()
        
        let categories = response.categories
        categories.forEach { (category) in
            Category.createCategory(model: category)
        }
        
        let rankings = response.rankings
        rankings.forEach { (ranking) in
            Ranking.createRanking(model: ranking)
        }
        CoreDataManager.sharedInstance.saveContext()
        populateModel()
    }
    
    private func populateModel() {
        sections.removeAll()
        if let categories = Category.fetchAllCategories() {
            self.categories = categories
            if categories.count > 0 {
                sections.append((sectionType: .category, expanded: true))
            }
        }
        
        if let rankings = Ranking.fetchAllRankings() {
            self.rankings = rankings
            if rankings.count > 0 {
                sections.append((sectionType: .ranking, expanded: true))
            }
        }
        delegate?.didReceiveData()
    }
}

