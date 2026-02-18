//
//  ServerStatistics.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 18.02.26.
//

import Foundation

nonisolated struct ServerStatistics: Decodable {
    var networkIncoming: Int?
    var networkOutgoing: Int?
    var uptime: Int?
    var memory: Int?
    var freeMemory: Int?
    var maxMemory: Int?
    var disk: Int?
    var maxDisk: Int?
    var processor: Double?
    var maxProcessor: Double?
    
    enum CodingKeys: String, CodingKey {
        case networkIncoming = "netin"
        case networkOutgoing = "netout"
        case uptime = "uptime"
        case memory = "mem"
        case freeMemory = "freemem"
        case maxMemory = "maxmem"
        case disk = "disk"
        case maxDisk = "maxdisk"
        case processor = "cpu"
        case maxProcessor = "cpus"
    }
}
