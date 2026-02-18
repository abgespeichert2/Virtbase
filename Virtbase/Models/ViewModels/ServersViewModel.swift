//
//  ServersViewModel.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 17.02.26.
//

import Alamofire
import Combine

class ServersViewModel: ObservableObject {
    
    @Published
    var processing: Bool = false
    
    @Published
    var servers: [Server]?
    
    func fetch(
        session: Session
    ) async {
        self.processing = true
        
        let address = (
            "https://virtbase.com/api/v1"
            + "/kvm/owned"
        )
        
        servers = try? await session.request(
            address,
            method: .get
        )
        .validate()
        .serializingDecodable([Server].self)
        .value
    
        self.processing = false
    }
}
