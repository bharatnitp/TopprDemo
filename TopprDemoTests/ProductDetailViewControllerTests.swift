//
//  ProductDetailViewControllerTests.swift
//  TopprDemoTests
//
//  Created by Bharat Bhushan on 11/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//


import XCTest

@testable import TopprDemo

class ProductDetailViewControllerTests: XCTestCase {
    var viewController: ProductDetailViewController!
    var responseModel: ResponseModel!
    var products = [Product]()
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyBoard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController
        viewController.loadView()
        responseModel = MockApiService().eCommerceJSON()
        for product in responseModel.categories.first?.products ?? [] {
            let item = Product.createProduct(model: product)
            products.append(item)
        }
        viewController.products = products
    }
    
    override func tearDown() {
        viewController = nil
        responseModel = nil
        products = []
        super.tearDown()
    }
    
    func test_tableViewMethods() {
        
        let numberRowsInSection1 = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertTrue(numberRowsInSection1 == products.count)
        
        let rowHeight = viewController.tableView(viewController.tableView, heightForRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(rowHeight == 64)
        
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(cell.isKind(of: GenericTableViewCell.self))
        
        if let cell = (cell as? GenericTableViewCell), products.count > 0 {
            cell.configureCell(with: products.first as Any)
        }
        
        viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
    }
}
