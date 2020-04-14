//
//  ExtensionUIImageView.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import UIKit

extension UIImageView {
    public func load(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error)-> Void in
            DispatchQueue.main.async {
                let image = UIImage(data: data!)
                self.image = image
            }
        }).resume()
    }
}
