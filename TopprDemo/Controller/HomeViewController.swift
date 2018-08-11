//
//  HomeViewController.swift
//  TopprDemo
//
//  Created by Bharat Bhushan on 10/08/18.
//  Copyright © 2018 Bharat Bhushan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: HomeViewModel!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "E-Commerce"
        tableView.isHidden = true
        viewModel = HomeViewModel(delegate: self)
        registerNibs()
        activityIndicator.startAnimating()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func registerNibs() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
    }
    
    @objc private func refreshTableView() {
        refreshControl.beginRefreshing()
        viewModel.getData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: Any? = viewModel.itemForRow(in: indexPath.section, at: indexPath.row)
        if let model = model {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.configureCell(with: model)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushProductDetailViewController(indexPath.section, indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = UINib(nibName: "HeaderView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? HeaderView {
            let title = viewModel.titleForHeader(in: section)
            let expanded = viewModel.sections[section].expanded
            view.delegate = self
            view.configureView(with: title, section: section, expanded: expanded)
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    func pushProductDetailViewController(_ section: Int, _ row: Int) {
        guard let products = viewModel.getProducts(section, row), products.count > 0 else { return }
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            viewController.title = "Detail"
            viewController.products = products
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didReceiveData() {
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func didReceiveError() {
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
        tableView.isHidden = true
        self.showAlert(title: "Error!", message: "Something went wrong.Please try again later")
    }
}

extension HomeViewController: HeaderViewDelegate {
    func toggleSection(shouldExpand: Bool, _ section: Int) {
        viewModel.toggleSection(shouldExpand: shouldExpand, section)
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
