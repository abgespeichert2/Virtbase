//
//  ServerTaskView.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 18.02.26.
//

import SwiftUI

struct ServerTaskView: View {
    
    var task: ServerTask
    
    var body: some View {
        Group {
            switch task {
            case .rebooting:
                Text("Neustart läuft")
            case .stopping:
                Text("Wird gestoppt")
            case .shutting:
                Text("Wird heruntergefahren")
            case .resuming:
                Text("Wird fortgesetzt")
            case .pausing:
                Text("Wird pausiert")
            case .suspending:
                Text("Wird ausgesetzt")
            case .backing:
                Text("Backup wird erstellt")
            case .restoring:
                Text("Wird wiederhergestellt")
            case .starting:
                Text("Wird gestartet")
            case .resetting:
                Text("Wird zurückgesetzt")
            case .unknown:
                Text("Unbekannt")
            }
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
}
