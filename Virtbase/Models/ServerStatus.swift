//
//  ServerStatus.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 18.02.26.
//

import Foundation

enum ServerStatus: String, Codable {
    case running = "RUNNING"
    case stopped = "STOPPED"
    case paused = "PAUSED"
    case suspended = "SUSPENDED"
    case unknown = "UNKNOWN"
}
