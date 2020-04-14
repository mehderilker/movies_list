//
//  ArenaType.swift
//  Movies
//
//  Created by ilker on 8.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import UIKit.UIViewController

enum ArenaType: Arena {
    case homePage
    case movieDetail(movieId: Int)
    
    var viewController: UIViewController?{
        switch self {
        case .homePage:
            return self.buildHomePage()
            
        case let .movieDetail(movieId):
            return self.buildMovieDetail(movieId: movieId)
            
        default:
            print("TODO: Call builder from arena extension. \(self)")
            return nil
        }
        
    }
}

