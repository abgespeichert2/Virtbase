//
//  ContentView.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 12.02.26.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private
    var authentication: AuthenticationModel
    
    var body: some View {
        VStack {
            
            Button("TMP Abmeldung") {
                authentication.state = .deauthenticated
            }
            
            Button("Abmeldung") {
                Task {
                    try authentication.deauthenticate()
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
