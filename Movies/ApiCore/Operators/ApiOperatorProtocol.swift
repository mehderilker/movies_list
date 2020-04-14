//
//  ApiOperatorProtokol.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import Foundation

protocol ApiOperatorProtocol
{
    func operate(requestInfo: ApiRequestInfo, environment: ApiEnvironment, onCompleted: @escaping (Result<Data?, ApiError>) -> Void)
}
