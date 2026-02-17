//
//  InterceptorModel.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 12.02.26.
//

import Foundation
import Alamofire

final class InterceptorModel: RequestInterceptor {
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var request = urlRequest
        
        request.headers.update(name: "Accept", value: "application/json")
        request.headers.update(name: "Content-Type", value: "application/json")
        request.headers.update(name: "User-Agent", value: "Virtbase/1.0")
        request.headers.update(name: "Origin", value: "https://virtbase.com")
        
        if let token = try? KeychainModel.read() {
            request.headers.update(name: "X-Virtbase-API-Key", value: token)
        }
        
        completion(.success(request))
    }
}
