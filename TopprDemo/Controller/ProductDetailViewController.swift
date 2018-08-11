//
//  ProductDetailViewController.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 11/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var products: [Product]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VariantTableViewCell", for: indexPath) as! VariantTableViewCell
        cell.configureCell(with: products[indexPath.row])
        return cell
    }
}
