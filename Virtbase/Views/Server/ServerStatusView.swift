//
//  ServerStatusView.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 18.02.26.
//

import SwiftUI

struct ServerStatusView: View {
    
    var status: ServerStatus
    
    var body: some View {
        switch status {
        case .running:
            Image(systemName: "play.fill")
                .foregroundStyle(.green)
                .font(.caption)
            
            Text("Online")
                .foregroundStyle(.secondary)
                .font(.subheadline)
        case .stopped:
            Image(systemName: "stop.fill")
                .foregroundStyle(.red)
                .font(.caption)
            
            Text("Offline")
                .foregroundStyle(.secondary)
                .font(.subheadline)
        case .paused:
            Image(systemName: "pause.fill")
                .foregroundStyle(.yellow)
                .font(.caption)
            
            Text("Pausiert")
                .foregroundStyle(.secondary)
                .font(.subheadline)
        case .suspended:
            Image(systemName: "moon.fill")
                .foregroundStyle(.yellow)
                .font(.caption)
            
            Text("Suspendiert")
                .foregroundStyle(.secondary)
                .font(.subheadline)
        case .unknown:
            Image(systemName: "questionmark.circle.fill")
                .foregroundStyle(.tertiary)
                .font(.caption)
            
            Text("Unbekannt")
                .foregroundStyle(.secondary)
                .font(.subheadline)
        }
    }
}
