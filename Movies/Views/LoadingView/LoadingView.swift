//
//  LoadingView.swift
//  Movies
//
//  Created by ilker on 13.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var viewLoadingIndicator: UIActivityIndicatorView!
    
    enum VisibilityType {
        case hide
        case show(onView: UIView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.extLoadViewFromNib()
    }
    
    func configure() {
        self.viewLoadingIndicator.color = .red
        self.viewLoadingIndicator.startAnimating()
    }
}
