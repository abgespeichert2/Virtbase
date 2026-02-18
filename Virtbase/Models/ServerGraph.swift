//
//  ServerGraph.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 18.02.26.
//

import Foundation

nonisolated struct ServerGraph: Decodable {
    var processor: Double
    var memory: Double
    var maximumMemory: Double
    var diskRead: Double
    var diskWrite: Double
    var networkIncoming: Double
    var networkOutgoing: Double
    var time: Date
    
    enum CodingKeys: String, CodingKey {
        case processor = "cpu"
        case memory = "mem"
        case maximumMemory = "maxmem"
        case diskRead = "diskread"
        case diskWrite = "diskwrite"
        case networkIncoming = "netin"
        case networkOutgoing = "netout"
        case time = "time"
    }
}
