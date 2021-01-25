//
//  HomeViewController.swift
//  Challenge
//
//  Created by Gabriel Ribeiro dos Santos on 15/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var emptyLabel: UILabel!
    
    //MARK: Variables
    
    var dataIndex: [Int]?
    let viewModel = HomeViewModel()
    internal let rControl = UIRefreshControl()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configObservers()
        self.configLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Observables
    
    func configObservers() {
        self.viewModel.showLoading.observe { _, show in
            self.showLoading( show )
        }
        
        self.viewModel.showEmptyLabel.observe { _, show in
            self.emptyLabel.isHidden = !show
            self.tableView.reloadData()
        }
        
        self.viewModel.showErrorMessage.observe { _, message in
            if message != nil {
                self.showErrorMessage(message! )
            }
        }
        
        
        self.viewModel.charachters.observe { (_, charachters ) in
            self.rControl.endRefreshing()
            self.tableView.reloadData()
        }
        
        self.viewModel.dataObserver.observe{ (_, data) in
            self.dataIndex = data
        }
        
        self.viewModel.initViewModel()
    }
    
    //MARK: Private Functions
    
    private func configLayout() {
        
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        self.title = "Rick & Morty Characters"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = rControl
        } else {
            self.tableView.addSubview(rControl)
        }
        rControl.tintColor = .white
        rControl.attributedTitle = NSAttributedString(string: "Push to refresh", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        rControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.updateCharachters()
    }
    
    private func showLoading(_ show: Bool) {
        if !rControl.isRefreshing {
            self.tableView.isHidden = show
        }
    }
    
    private func updateCharachters() {
        self.viewModel.updateCharachters()
    }
    
    //MARK: Functions
    
    func saveFavorite(_ id: Int) {
        self.viewModel.data.append(id)
    }
    
    func removeFavorite(_ id: Int) {
        
        if let index = self.viewModel.data.firstIndex(of: id) {
            self.viewModel.data.remove(at: index)
        }
    }
    
    func showErrorMessage(_ error: NSError) {
        
        var alertVC = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertVC = showErrorMessageDefault(error: error, action: okAction)
        
        self.present(alertVC, animated: true) {
            alertVC.setDismissOnTapOutside()
        }
    }
    
    func showErrorMessageDefault(error: NSError, action: UIAlertAction?)-> UIAlertController {
        return ErrorManager.sharedInstance.showErrorMessageDefault(error, action: action)
    }
    
    func loadCharachter(_ char: Charachter) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeDetailViewControllerIdentifier") as? HomeDetailViewController {
            viewController.charachter = char
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
}

//MARK: Extensions

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.charachters.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeItemCellIdentifier", for: indexPath) as! HomeItemCell
        let charData = self.viewModel.charachters.value[indexPath.row]
        
        if let id = charData.charId {
            if let data = self.dataIndex {
                if data.contains(id) {
                    cell.isFavorite = true
                } else {
                    cell.isFavorite = false
                }
            }
        }
        
        cell.configureForItem(charData)
        cell.link = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let charachter = self.viewModel.charachters.value[indexPath.row]
        self.loadCharachter(charachter)
    }
}

extension UIAlertController {
    @objc func dismissMe(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setDismissOnTapOutside(){
        self.view.superview?.isUserInteractionEnabled = true
        self.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissMe)))
    }
}
