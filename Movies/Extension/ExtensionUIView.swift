//
//  ExtensionUIView.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import UIKit.UIView

extension UIView {
    func extSetVisibility(_ shouldShow: Bool) {
        self.isHidden = !shouldShow
    }
    
    @discardableResult
    func extLoadViewFromNib() -> UIView? {
        let viewTypeToLoad = type(of: self)
        let viewNameToLoad = String(describing: viewTypeToLoad)
        guard let viewLoaded = Bundle.main.loadNibNamed(viewNameToLoad, owner: self, options: nil)?.first as? UIView else {
            print("Failed to load \(viewNameToLoad)")
            return nil
        }
        
        self.addSubview(viewLoaded)
        viewLoaded.frame = self.bounds
        viewLoaded.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return self
    }
    
    public func extConstrainToEdges(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0)
        
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
}
