//
//  VirtbaseApp.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 12.02.26.
//

import SwiftUI

@main
struct VirtbaseApp: App {
    
    @StateObject private
    var authenticationModel: AuthenticationModel
    = AuthenticationModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch authenticationModel.state {
                case .authenticated:
                    ContentView()
                case .processing, .deauthenticated:
                    KeyOnboardingView()
                case .unknown:
                    ProgressView()
                }
            }
            .environmentObject(authenticationModel)
            .task {
                await authenticationModel.refresh()
            }
        }
    }
}
