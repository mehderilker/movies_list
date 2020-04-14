//
//  MovieDetailCell.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import UIKit

class MovieDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelVote: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureDisplay()
    }
    
    private func configureDisplay(){
        self.configureLabel()
    }
    private func configureLabel(){
        self.labelTitle.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        self.labelVote.font = UIFont.boldSystemFont(ofSize: 12)
        
        self.labelDetail.font = UIFont.italicSystemFont(ofSize: 20)
    }
}
