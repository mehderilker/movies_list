//
//  LoadingManager.swift
//  Movies
//
//  Created by ilker on 13.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import UIKit

class LoadingManager {
    
    static let shared: LoadingManager = LoadingManager()
    
    var coverView: UIView? {
        didSet {
            oldValue?.extSetVisibility(false)
            oldValue?.removeFromSuperview()
        }
    }
    
    func setLoadingVisibility(_ visibility: LoadingView.VisibilityType) {
        switch visibility {
        case let .show(onView):
            self.showLoading(on: onView)
        case .hide:
            self.hideLoading()
        }
    }
    
    func hideLoading() {
        self.coverView?.extSetVisibility(false)
        self.coverView?.removeFromSuperview()
    }
    
    func showLoading(on parentView: UIView) {
        let coveringView = UIView(frame: parentView.frame)
        coveringView.backgroundColor =  UIColor.darkGray.withAlphaComponent(0.3)
        
        let loadingView = LoadingView(frame: parentView.frame)
        coveringView.addSubview(loadingView)
        coveringView.extConstrainToEdges(loadingView)
        
        parentView.addSubview(coveringView)
        parentView.extConstrainToEdges(coveringView)
        
        coveringView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        loadingView.configure()
        
        self.coverView = coveringView
    }
}
