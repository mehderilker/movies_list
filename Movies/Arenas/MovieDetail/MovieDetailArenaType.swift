//
//  MovieDetailArenaType.swift
//  Movies
//
//  Created ilker on 8.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//
//  Template generated by Suat Karakusoglu
//

import UIKit.UIViewController
import UIKit.UINavigationController

extension ArenaType
{
    func buildMovieDetail(movieId: Int) -> UIViewController {
        let viewController = MovieDetailViewController()
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor(movieId: movieId)
        self.build(
            view: viewController,
            presenter: presenter,
            interactor: interactor)
        
        presenter.router = MovieDetailRouter(arenaPresenter: viewController)
        
        return viewController
    }
}
