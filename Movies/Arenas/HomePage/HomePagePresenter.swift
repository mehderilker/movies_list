//
//  HomePagePresenter.swift
//  Movies
//
//  Created ilker on 8.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//
//  Template generated by Suat Karakusoglu
//

import UIKit

final class HomePagePresenter: Presenter {
    
    typealias Command = HomePagePresenterCommand
    
    typealias Event = HomePageViewEvent
    
    typealias Request = HomePageInteractorRequest
    
    typealias Response = HomePageInteractorResponse
    
    var requestListener: AnyRequestListener<HomePageInteractorRequest>?
    
    var commandListener: AnyCommandListener<HomePagePresenterCommand>?
    
    var router: HomePageRouter?
    
    func handle(event: HomePageViewEvent) {
        switch event {
        case .viewDidLoad:
            self.commandListener?.handle(command: .setLoadingViewVisibility(shouldShow: true))
            self.requestListener?.handle(request: .getMoviesList)
            
        case let .openDetailPage(movieId):
            self.router?.route(to: .movieDetail(movieId: movieId))
        @unknown default:
            print("ViewEvent should be handled at \(#function)")
        }
    }
    
    func handle(response: HomePageInteractorResponse) {
        switch response {
        case let .getMoviesListResponse(movies):
            self.commandListener?.handle(command: .loadMovies(movies: movies))
            self.commandListener?.handle(command: .setLoadingViewVisibility(shouldShow: false))
            
        case  .getMoviesListResponseFailed:
            self.commandListener?.handle(command: .setLoadingViewVisibility(shouldShow: false))
        @unknown default:
            print("InteractorResponse should be handled at \(#function)")
        }
    }
}