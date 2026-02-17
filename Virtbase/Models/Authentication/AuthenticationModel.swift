//
//  AuthenticationModel.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 12.02.26.
//

import Foundation
import Alamofire
import Combine

enum AuthenticationState: CaseIterable {
    case authenticated
    case deauthenticated
    case processing
    case unknown
}

class AuthenticationModel: ObservableObject {
    
    @Published
    var state: AuthenticationState
    = AuthenticationState.unknown
    
    @Published
    var session: Session
    
    init() {
        // we use 'ephemeral' here, so we dont save any cookies
        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = false

        let session = Session(
            configuration: configuration,
            interceptor: InterceptorModel()
        )
        self.session = session
    }
    
    func authenticate(
        token: String
    ) async throws {
        
        self.state =
        AuthenticationState.processing
        
        // first write token to keychain
        // if that fails we cancel
        try KeychainModel.write(
            token: token
        )
        
        let address = "https://virtbase.com/api/v1/kvm/owned"
        let result = await session.request(address)
            .validate(statusCode: 200..<300)
            .serializingData()
            .result

        switch result {
        case .success:
            self.state = .authenticated
            print("succeeded!")
        case .failure:
            self.state = .deauthenticated
            print("failed!")
        }
    }
    
    func refresh() async {
        let address = "https://virtbase.com/api/v1/kvm/owned"
        let result = await session.request(address)
            .validate(statusCode: 200..<300)
            .serializingData()
            .result

        switch result {
        case .success:
            self.state = .authenticated
        case .failure:
            self.state = .deauthenticated
        }
    }
    
    func deauthenticate() throws {
        try KeychainModel.delete()
        
        self.state =
        AuthenticationState.deauthenticated
    }
}
