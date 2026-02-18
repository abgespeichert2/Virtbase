//
//  ServerTemplate.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 17.02.26.
//

import Foundation

nonisolated struct ServerTemplate: Identifiable, Decodable {
    var id: String
    var name: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case icon = "icon"
    }
}
