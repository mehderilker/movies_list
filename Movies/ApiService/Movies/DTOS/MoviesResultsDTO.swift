//
//  MoviesDetailDTO.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import Foundation

struct MoviesResultsDTO: Codable {
    let id: Int
    let title : String
    let vote_count: Int
    let overview: String
    let release_date : String
    let poster_path: String
}

