//
//  VariantTableViewCell.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 11/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//

import UIKit

class VariantTableViewCell: UITableViewCell {
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    func configureCell(with product: Product) {
        nameLabel.text = product.name ?? ""
        taxLabel.text = "\(product.tax?.name ?? ""): \(product.tax?.value ?? 0.0)"
        dateLabel.text = ""
        if let date = product.dateAdded {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
            if let dateAdded = dateformatter.date(from: date) {
                dateformatter.dateFormat = "dd/MM/YYYY"
                dateLabel.text = "\(dateformatter.string(from: dateAdded))"
            }
        }
    }
}
