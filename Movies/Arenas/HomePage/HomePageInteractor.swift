//
//  HomePageInteractor.swift
//  Movies
//
//  Created ilker on 8.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//
//  Template generated by Suat Karakusoglu
//

import UIKit

final class HomePageInteractor: Interactor {
    
    typealias Response = HomePageInteractorResponse
    typealias Request = HomePageInteractorRequest
    let apiService = MoviesApiService()

    var responseListener: AnyResponseListener<HomePageInteractorResponse>?
    
    init() {
        // Inject api services here from arguments
    }
    
    func handle(request: HomePageInteractorRequest) {
        switch request {
        case .getMoviesList:
            self.apiService.getMoviesPopular{ (response,error) in
                guard let response = response else {
                    self.responseListener?.handle(response: .getMoviesListResponseFailed)
                    return
                }
                
                self.responseListener?.handle(response: .getMoviesListResponse(movies: response))
            }
        @unknown default:
            print("InteractorRequest should be handled at \(#function)")
        }
    }
}
