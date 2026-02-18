//
//  ServerStateViewModel.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 17.02.26.
//

import Alamofire
import Combine

class ServerStateViewModel: ObservableObject {
    
    @Published
    var state: ServerState?
    
    func fetch(
        session: Session,
        server: Server
    ) async {
        let address = (
            "https://virtbase.com/api/v1"
            + "/kvm/\(server.id)/status"
        )
        
        state = try? await session.request(
            address,
            method: .get
        )
        .validate()
        .serializingDecodable(ServerState.self)
        .value
    }
}
