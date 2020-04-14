//
//  ApiDecoderProtocol.swift
//  Movies
//
//  Created by ilker on 12.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import Foundation

protocol ApiDecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T? where T : Decodable
}
