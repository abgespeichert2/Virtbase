//
//  ServerState.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 17.02.26.
//

import Foundation

nonisolated struct ServerState: Decodable {
    var status: ServerStatus
    var statistics: ServerStatistics?
    var task: ServerTask?
    var installed: String?
    var suspended: String?
    var terminates: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case statistics = "stats"
        case task = "task"
        case installed = "installedAt"
        case suspended = "suspendedAt"
        case terminates = "terminatesAt"
    }
}
