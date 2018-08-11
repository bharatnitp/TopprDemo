//
//  HeaderView.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
    func toggleSection(shouldExpand: Bool, _ section: Int)
}

class HeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    var section: Int = 0
    weak var delegate: HeaderViewDelegate?
    
    private var sectionIsExpanded: Bool = true {
        didSet {
            UIView.animate(withDuration: 0.25) {
                if self.sectionIsExpanded {
                    self.toggleButton.transform = CGAffineTransform.identity
                } else {
                    self.toggleButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                }
            }
        }
    }
    
    func configureView(with title: String, section: Int, expanded: Bool) {
        sectionIsExpanded = expanded
        self.section = section
        titleLabel.text = title
    }
    
    @IBAction func toggleButtonTapped(_ sender: Any) {
        sectionIsExpanded = !sectionIsExpanded
        delegate?.toggleSection(shouldExpand: sectionIsExpanded, section)
    }
}
