//
//  ProductVariantViewController.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 11/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//

import UIKit

class ProductVariantViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var variants: [Variant]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
    }
}

extension ProductVariantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return variants.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenericTableViewCell", for: indexPath) as! GenericTableViewCell
        cell.accessoryType = .none
        cell.configureCell(with: variants[indexPath.row])
        return cell
    }
}
