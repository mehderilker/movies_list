//
//  MoviesApiService.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import Foundation

class MoviesApiService {
    func getMoviesPopular(completionHandler: @escaping (MoviesDTO?,Error?) -> Void) {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=d3be635ae0a261b6b32003414038373d")
        let sharedSession = URLSession.shared
        var webRequest = URLRequest(url: url!)
        webRequest.httpMethod = "GET"
    
        sharedSession.dataTask(with: url!) { (webData, urlResponse, apiError) in
            
            if let data = webData {
                do {
                    let res = try JSONDecoder().decode(MoviesDTO.self, from: data)
                    completionHandler(res,nil)
                } catch let error {
                    completionHandler(nil,error)
                }
            }
            
        }.resume()
    }
    
    func getMovieDetail(movieId: Int ,completionHandler: @escaping (MovieDetailDTO?,Error?) -> Void) {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=d3be635ae0a261b6b32003414038373d")
        let sharedSession = URLSession.shared
        var webRequest = URLRequest(url: url!)
        webRequest.httpMethod = "GET"
        
        sharedSession.dataTask(with: url!) { (webData, urlResponse, apiError) in
            
            if let data = webData {
                do {
                    let res = try JSONDecoder().decode(MovieDetailDTO.self, from: data)
                    completionHandler(res,nil)
                } catch let error {
                    completionHandler(nil,error)
                }
            }
            
        }.resume()
    }
}
