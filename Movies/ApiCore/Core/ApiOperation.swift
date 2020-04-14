////
////  ApiOperation.swift
////  Movies
////
////  Created by ilker on 12.04.2020.
////  Copyright © 2020 ilker. All rights reserved.
////
//
//import Foundation
//
//protocol ApiOperation: Codable
//{
//    associatedtype ApiRequestDTO: Codable
//    associatedtype ApiResponseType: Codable
//
//    var requestDTO: ApiRequestDTO { get }
//    var requestInfo: ApiRequestInfo { get }
//
//    func run(
//        apiEnvironment: () -> ApiEnvironment,
//        apiOperator: ApiOperatorProtocol,
//        apiDecoder: ApiDecoderProtocol,
//        onCompleted: @escaping (Swift.Result<ApiResponseType?, ApiError>) -> Void
//    );
//}
//
//extension ApiOperation
//{
//    func parameters() -> [String: Any]?
//    {
//        guard let jsonData = try? JSONEncoder().encode(self.requestDTO) else { return nil }
//        guard let parameters = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else { return nil }
//        return parameters
//    }
//
//    func run(
//        apiEnvironment: () -> ApiEnvironment =  ApiEnvironmentType.default.getContent,
//        apiOperator: ApiOperatorProtocol = AlamofireApiOperator.instance,
//        apiDecoder: ApiDecoderProtocol = JsonResponseDecoder.instance,
//        onCompleted:  @escaping (Swift.Result<ApiResponseType?, ApiError>) -> Void)
//    {
//        let environment = apiEnvironment()
//        
//        apiOperator.operate(requestInfo: self.requestInfo, environment: environment) { (result) in
//            switch result {
//            case .success(let responseData):
//                do {
//                    if let responseData = responseData, !responseData.isEmpty {
//                        if let result = try apiDecoder.decode(ApiResponseType.self, from: responseData) {
//                            onCompleted(.success(result))
//                        }
//                    }else {
//                        onCompleted(.success(nil))
//                    }
//                } catch let error {
//                    onCompleted(.failure(.failedDecoding(error)))
//                }
//            case .failure(let error):
//                onCompleted(.failure(error))
//            }
//        }
//    }
//}
