//
//  MovieDetailDTO.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import Foundation

struct MovieDetailDTO: Codable {
    let id: Int
    let original_title : String
    let vote_average: Double
    let overview: String
    let backdrop_path: String
}
