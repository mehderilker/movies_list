//
//  ApiError.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import Foundation

enum ApiError: LocalizedError
{
    case httpFail(errorStatus: ApiErrorStatusResponse?)
    case noResponse
    case noData
    case failedDecoding(_ internalError: Error)
    case operationCouldNotInit(message: String)
    
    public var errorDescription: String? {
        switch self {
        case .httpFail(let errorStatus):
            return errorStatus?.message
        case .noResponse:
            return NSLocalizedString("No response is returned from service.", comment: "ApiError noResponse")
        case .noData:
            return NSLocalizedString("No data is returned from service.", comment: "ApiError noData")
        case .failedDecoding(let error):
            return NSLocalizedString("Data is failed to be decoded: \(error.localizedDescription)", comment: "ApiError failedDecoding response")
        case .operationCouldNotInit(let message):
            return NSLocalizedString("Operation could not initialized \(message).", comment: "ApiError operationCouldNotInit")
        }
    }
}

struct ApiErrorStatusResponse: Codable
{
    let statusCode: Int
    let message: String?
}
