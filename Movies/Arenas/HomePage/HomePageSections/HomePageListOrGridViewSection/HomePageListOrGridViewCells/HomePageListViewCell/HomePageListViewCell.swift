//
//  HomePageListViewCell.swift
//  Movies
//
//  Created by ilker on 11.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import UIKit

class HomePageListViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewHomePageList: UIView!
    @IBOutlet weak var imageViewFavorite: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureShadow()
    }
    private func configureShadow(){
        self.viewHomePageList.layer.shadowColor = UIColor.black.cgColor
        self.viewHomePageList.layer.shadowOpacity = 0.2
        self.viewHomePageList.layer.shadowOffset = .zero
        self.viewHomePageList.layer.shadowRadius = 6
    }
}
