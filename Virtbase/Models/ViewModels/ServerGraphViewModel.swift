//
//  ServerGraphViewModel.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 18.02.26.
//

import Foundation
import Alamofire
import Combine

class ServerGraphViewModel: ObservableObject {
    
    @Published
    var samples: [ServerGraph]?
    
    func fetch(
        session: Session,
        server: Server
    ) async {
        let address = (
            "https://virtbase.com/api/v1"
            + "/kvm/\(server.id)/graphs"
            + "?timeframe=hour"
        )
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        samples = try! await session.request(
            address,
            method: .get
        )
        .validate()
        .serializingDecodable(
            [ServerGraph].self,
            decoder: decoder
        )
        .value
    }
}
