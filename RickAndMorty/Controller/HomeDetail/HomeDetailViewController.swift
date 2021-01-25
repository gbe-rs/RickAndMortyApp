//
//  HomeDetailViewController.swift
//  Challenge
//
//  Created by Gabriel Ribeiro dos Santos on 15/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import UIKit

class HomeDetailViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet var charImageView: UIImageView!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var lblSpecies: UILabel!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var lblOrigin: UILabel!
    @IBOutlet var lblLocation: UILabel!
    
    //MARK: Variables
    
    var charachter: Charachter?
    
    internal let rControl = UIRefreshControl()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configLayout(charachter!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Private Functions
    
    private func configLayout(_ char: Charachter) {
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Rockwell", size: 18)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        if let img = char.image {
            if let url = URL(string: img) {
                if let data = try? Data(contentsOf: url) {
                    self.charImageView.image = UIImage(data: data)
                }
            }
        }
        
        self.title = char.charName
        self.lblStatus.text = "Status: \(char.status ?? "")"
        self.lblSpecies.text = "Species: \(char.species ?? "")"
        self.lblGender.text = "Gender: \(char.gender ?? "")"
        self.lblOrigin.text = "Origin: \(char.origin?.name ?? "")"
        self.lblLocation.text = "Location: \(char.location?.name ?? "")"
    }
}

