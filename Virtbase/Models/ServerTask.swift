//
//  ServerTask.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 18.02.26.
//

import Foundation

enum ServerTask: String, Codable {
    case rebooting = "REBOOTING"
    case stopping = "STOPPING"
    case shutting = "SHUTTING_DOWN"
    case resuming = "RESUMING"
    case pausing = "PAUSING"
    case suspending = "SUSPENDING"
    case backing = "BACKING_UP"
    case restoring = "RESTORING_BACKUP"
    case starting = "STARTING"
    case resetting = "RESETTING"
    case unknown = "UNKNOWN"
}
