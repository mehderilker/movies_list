//
//  ApiConnectedInfo.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import Foundation

struct ApiConnectionInfo
{
    let apiVersion: String?
    let relativePath: String
    let method: ApiHttpMethodType
    
    func getRelativeUrlPath() -> String
    {
        var apiVersionPath = ""
        if let apiVersion = self.apiVersion {
            apiVersionPath = apiVersion + "/"
        }

        return apiVersionPath + self.relativePath
    }
}
