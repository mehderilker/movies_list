//
//  ApiEnvironmentType.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import Foundation

enum ApiEnvironmentType {
    case `default`

    func getContent() -> ApiEnvironment {
        switch self {
        case .`default`:
            return ApiEnvironmentType.getDefaultEnvironment()
        }
    }
}

extension ApiEnvironmentType {
    
    static func getDefaultHeaders() -> [String: String] {
        let defaultHeaders = [
            "Content-Type": "application/json",
        ]
        
        return defaultHeaders.compactMapValues{ $0 }
    }
    
    static func getDefaultEnvironment() -> ApiEnvironment {
        let defaultEnvironmentHeaders = ApiEnvironmentType.getDefaultHeaders()
        let productionEnvironment = ApiEnvironment(
            name: "Movies  Api",
            host: "https://api.themoviedb.org",
            defaultHeaders: defaultEnvironmentHeaders
        )
        
        return productionEnvironment
    }
}
