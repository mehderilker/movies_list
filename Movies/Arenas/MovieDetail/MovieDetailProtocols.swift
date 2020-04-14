//
//  MovieDetailProtocols.swift
//  Movies
//
//  Created ilker on 8.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//
//  Template generated by Suat Karakusoglu
//

import Foundation

enum MovieDetailViewEvent: ViewEvent {
    case viewDidLoad
    case backAction
}

enum MovieDetailPresenterCommand: PresenterCommand {
    case loadMovieDetail(movieDetail: MovieDetailDTO)
    case setLoadingViewVisibility(shouldShow : Bool)
}

enum MovieDetailInteractorRequest: InteractorRequest {
    case getMovieDetail
}

enum MovieDetailInteractorResponse: InteractorResponse {
    case getMovieDetailResponse(movieDetail: MovieDetailDTO)
    case getMovieDetailResponseFailed
}

