//
//  ServerPackage.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 17.02.26.
//

import Foundation

nonisolated struct ServerPackage: Identifiable, Decodable {
    var id: String
    var cores: Int
    var memory: Int
    var storage: Int
    var bandwidth: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cores = "cores"
        case memory = "memory"
        case storage = "storage"
        case bandwidth = "netrate"
    }
}
