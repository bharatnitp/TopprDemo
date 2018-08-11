//
//  HomeViewControllerTests.swift
//  TopprDemoTests
//
//  Created by Bharat Bhushan on 11/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//

import XCTest

@testable import TopprDemo

class MockApiService {
    func eCommerceJSON() -> ResponseModel? {
        if let supportResponseFilePath = Bundle.main.path(forResource: "E-Commerce", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: supportResponseFilePath)) {
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(ResponseModel.self, from: data)
                    return model
                } catch {
                    
                }
            }
        }
        return nil
    }
}

class HomeViewControllerTests: XCTestCase {
    var viewController: HomeViewController!
    var responseModel: ResponseModel!
    var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
         let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         let navVC = storyBoard.instantiateViewController(withIdentifier: "MainNavVC") as! UINavigationController
         viewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        navVC.viewControllers = [viewController]
        viewController.loadView()
        responseModel = MockApiService().eCommerceJSON()
        viewModel = HomeViewModel(delegate: viewController)
        viewController.viewModel = viewModel
        viewModel.saveResponseToCoreData(response: responseModel)
    }
    
    override func tearDown() {
        viewController = nil
        viewModel = nil
        responseModel = nil
        super.tearDown()
    }
    
    func test_numberOfSections() {
       let noOfSections = viewModel.numberOfSections
       XCTAssertTrue(noOfSections == 2)
    }
    
    func test_numberOfRows() {
        let noOfRows1 = viewModel.numberOfRows(in: 0)
        XCTAssertTrue(noOfRows1 == viewModel.categories.count)
        
        let noOfRows2 = viewModel.numberOfRows(in: 1)
        XCTAssertTrue(noOfRows2 == viewModel.rankings.count)
    }
    
    func test_itemForRow() {
       let item = viewModel.itemForRow(in: 0, at: 0)
       XCTAssertTrue(item != nil)
    }
    
    func test_titleForHeader() {
        var title = viewModel.titleForHeader(in: 0)
        XCTAssertTrue(title == "Select Product By Category")
        title = viewModel.titleForHeader(in: 1)
        XCTAssertTrue(title == "Select Product By Ranking")
    }
    
    func  test_toggleSection() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        viewController.tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        viewController.toggleSection(shouldExpand: true, 0)
        XCTAssertTrue(viewModel.sections[0].expanded == true)
    }
    
    func test_getProducts() {
        let products = viewModel.getProducts(0, 0)
        XCTAssertTrue(products?.count ?? 0 >= 0)
    }
    
    func test_getData() {
        viewModel.getData()
    }
    
    func test_tableViewMethods() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        viewController.tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        XCTAssertNotNil(nib)
        
        let numberOfSections = viewController.numberOfSections(in: viewController.tableView)
        XCTAssertTrue(numberOfSections == 2)
        
        let numberRowsInSection1 = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertTrue(numberRowsInSection1 == viewModel.categories.count)
        
        let numberRowsInSection2 = viewController.tableView(viewController.tableView, numberOfRowsInSection: 1)
        XCTAssertTrue(numberRowsInSection2 == viewModel.rankings.count)
        
        let rowHeight = viewController.tableView(viewController.tableView, heightForRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(rowHeight == 50)
        
        let headerHeight = viewController.tableView(viewController.tableView, heightForHeaderInSection: 0)
        XCTAssertTrue(headerHeight == 56)
        
        let header1 = viewController.tableView(viewController.tableView, viewForHeaderInSection: 0)
        XCTAssertNotNil(header1)
        
        let header2 = viewController.tableView(viewController.tableView, viewForHeaderInSection: 1)
        XCTAssertNotNil(header2)
        
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(cell.isKind(of: TableViewCell.self))
        
        if let cell = (cell as? TableViewCell), responseModel.categories.count > 0 {
            cell.configureCell(with: responseModel.categories.first as Any)
        }
        if let cell = (cell as? TableViewCell), responseModel.rankings.count > 0 {
            cell.configureCell(with: responseModel.rankings.first as Any)
        }
        viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
    }
}
