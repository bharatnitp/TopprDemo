//
//  ProductVariantViewControllerTests.swift
//  TopprDemoTests
//
//  Created by Bharat Bhushan on 11/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//

import XCTest

@testable import TopprDemo

class ProductVariantViewControllerTests: XCTestCase {
    
    var viewController: ProductVariantViewController!
    var responseModel: ResponseModel!
    var variants = [Variant]()
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyBoard.instantiateViewController(withIdentifier: "ProductVariantViewController") as? ProductVariantViewController
        viewController.loadView()
        responseModel = MockApiService().eCommerceJSON()
        for variant in responseModel.categories.first?.products.first?.variants ?? [] {
            let item = Variant.createVariant(model: variant)
            variants.append(item)
        }
        viewController.variants = variants
    }
    
    override func tearDown() {
        viewController = nil
        responseModel = nil
        variants = []
        super.tearDown()
    }
    
    func test_tableViewMethods() {
        
        let numberRowsInSection1 = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertTrue(numberRowsInSection1 == variants.count)
        
        let rowHeight = viewController.tableView(viewController.tableView, heightForRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(rowHeight == 64)
        
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(cell.isKind(of: GenericTableViewCell.self))
        
        if let cell = (cell as? GenericTableViewCell), variants.count > 0 {
            cell.configureCell(with: variants.first as Any)
        }
    }
}
