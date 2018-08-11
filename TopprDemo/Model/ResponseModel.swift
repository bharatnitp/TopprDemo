//
//  ResponseModel.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 09/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    let categories: [CategoryModel]
    let rankings: [RankingModel]
}

struct CategoryModel: Codable {
    let id: Int
    let name: String
    let products: [ProductModel]
    let childCategories: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case products = "products"
        case childCategories = "child_Categories"
    }
}

struct ProductModel: Codable {
    let id: Int
    let name: String
    let dateAdded: String
    let variants: [VariantModel]?
    let tax: TaxModel
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case dateAdded = "date_added"
        case variants = "variants"
        case tax = "tax"
    }
}

struct VariantModel: Codable {
    let id: Int
    let color: String?
    let size: Int?
    let price: Float
}

struct TaxModel: Codable {
    let name: String
    let value: Float?
}


struct RankingModel: Codable {
    let ranking: String
    let products: [[String: Int]]
}




