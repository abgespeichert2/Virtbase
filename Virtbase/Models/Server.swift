//
//  Server.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 17.02.26.
//

import Foundation

nonisolated struct Server: Identifiable, Decodable {
    var id: String
    var vmid: Int
    var name: String
    var package: ServerPackage
    var template: ServerTemplate
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case vmid = "vmid"
        case name = "name"
        case package = "kvmPackage"
        case template = "template"
    }
}
