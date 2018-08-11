//
//  TableViewCell.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func configureCell(with model: Any) {
        if let category = model as? Category {
            titleLabel.text = category.name ?? ""
            countLabel.text = "\(category.products?.count ?? 0)"
            return
        }
        
        if let ranking = model as? Ranking {
            titleLabel.text = ranking.rank
            countLabel.text = "\(ranking.productMetaData?.count ?? 0)"
        }
    }
}
