//
//  MoviesDTO.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import Foundation

struct MoviesDTO: Codable {
    let page: Int
    let results: [MoviesResultsDTO]
}
