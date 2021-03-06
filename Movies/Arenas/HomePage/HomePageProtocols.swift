//
//  HomePageProtocols.swift
//  Movies
//
//  Created ilker on 8.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//
//  Template generated by Suat Karakusoglu
//

import Foundation

enum HomePageViewEvent: ViewEvent {
    case viewDidLoad
    case openDetailPage(movieId: Int)
}

enum HomePagePresenterCommand: PresenterCommand {
    case loadMovies(movies: MoviesDTO)
    case setLoadingViewVisibility(shouldShow: Bool)
}

enum HomePageInteractorRequest: InteractorRequest {
    case getMoviesList
}

enum HomePageInteractorResponse: InteractorResponse {
    case getMoviesListResponse(movies: MoviesDTO)
    case getMoviesListResponseFailed
    
}

