//
//  HomeItemCell.swift
//  Challenge
//
//  Created by Gabriel Ribeiro dos Santos on 19/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import UIKit

class HomeItemCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var charImageView: UIImageView!
    @IBOutlet var btnFavorite: UIButton!
    @IBOutlet var lblFavorite: UILabel!
    @IBOutlet var imgArrow: UIImageView!
    
    // MARK: Variables
    
    var textChar : String?
    var isFavorite = false
    var isFavorited = false
    var link: HomeViewController?
    var idChar: Int?
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isFavorite = false
    }
    
    // MARK: Functions
    
    func configureForItem(_ charachter: Charachter) {

        if let name = charachter.charName {
            if name.contains("Rick") {
                textChar = "fav_rick"
            } else if name.contains("Morty") {
                textChar = "fav_morty"
            } else {
                textChar = "fav_snowball"
            }
        }
        
        if let id = charachter.charId {
            idChar = id
        }
        
        btnFavorite.backgroundColor = .yellow
        btnFavorite.layer.cornerRadius = btnFavorite.frame.height/2
        btnFavorite.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
        self.lblTitle.text = charachter.charName
        self.lblStatus.text = "Status: \(charachter.status ?? "")"
        
        if let img = charachter.image {
            if let url = URL(string: img) {
                if let data = try? Data(contentsOf: url) {
                    charImageView.image = UIImage(data: data)
                }
            }
        }
        
        if isFavorite {
            btnFavorite.setImage(UIImage(named: textChar ?? "") , for: .normal)
            lblFavorite.isHidden = true
            imgArrow.isHidden = true
            isFavorited = true

        } else {
            btnFavorite.setImage(nil, for: .normal)
            lblFavorite.isHidden = false
            imgArrow.isHidden = false
            isFavorited = false
        }
    }
    
    // MARK: Obj-c Functions
    
    @objc func handleMarkAsFavorite() {
        if !isFavorited {
            btnFavorite.setImage(UIImage(named: textChar ?? "") , for: .normal)
            lblFavorite.isHidden = true
            imgArrow.isHidden = true
            isFavorited = true
            
            if let id = idChar {
                link?.saveFavorite(id)
            }
        } else {
            btnFavorite.setImage(nil, for: .normal)
            lblFavorite.isHidden = false
            imgArrow.isHidden = false
            isFavorited = false
            
            if let id = idChar {
                link?.removeFavorite(id)
            }
        }               
        
    }
}

