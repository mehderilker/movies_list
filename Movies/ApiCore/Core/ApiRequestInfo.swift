//
//  ApiRequestInfo.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import Foundation

struct ApiRequestInfo
{
    let connectionInfo: ApiConnectionInfo
    var headers: [String: String]?
    var parameters: [String: Any]? = nil
    
    init(connectionInfo: ApiConnectionInfo,
         headers: [String: String]?,
         parameters: [String: Any]?)
    {
        self.connectionInfo = connectionInfo
        self.headers = headers
        self.parameters = parameters
    }
    
    func generateUrl(in environment: ApiEnvironment) -> URL?
    {
        let urlPath = environment.host + "/" + self.connectionInfo.getRelativeUrlPath()
        let url = URL(string: urlPath)
        return url
    }
}

