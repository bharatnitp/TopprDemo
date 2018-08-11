//
//  ProductDetailViewController.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 11/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var products: [Product]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenericTableViewCell", for: indexPath) as! GenericTableViewCell
        cell.configureCell(with: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushProductVariantViewController(index: indexPath.row)
    }
    
    func pushProductVariantViewController(index: Int) {
        
        guard let variants = products[index].variants?.allObjects as? [Variant], variants.count > 0 else {
            showAlert(title: "Item out of stock!!", message: "")
            return
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let viewControler = storyBoard.instantiateViewController(withIdentifier: "ProductVariantViewController") as? ProductVariantViewController {
            viewControler.variants = variants
            viewControler.title = "Variants"
            navigationController?.pushViewController(viewControler, animated: true)
        }
    }
}
