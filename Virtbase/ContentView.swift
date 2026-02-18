//
//  ContentView.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 12.02.26.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.openURL) private
    var openURL
    
    @EnvironmentObject private
    var authentication: AuthenticationModel
    
    @StateObject private
    var viewModel: ServersViewModel = .init()
    
    var body: some View {
        NavigationStack {
            
            List {
                if let servers = viewModel.servers {
                    ForEach(servers) { server in
                        Section {
                            ServerRowView(server: server)
                        }
                    }
                    
                    if servers.isEmpty {
                        Text("Keine Server")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                    }
                    
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding(10)
                }
            }
            .navigationTitle("Server")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        openURL(URL(string: "https://virtbase.com/de")!)
                    } label: {
                        Image(systemName: "plus")
                            .padding(.horizontal, 5)
                    }
                }
                
                ToolbarSpacer(.fixed, placement: .topBarTrailing)
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Aktualisieren") {
                        Upstream.refresh()
                    } .disabled(viewModel.processing)
                }
            }
            .task {
                await viewModel.fetch(
                    session: authentication.session
                )
            }
            .onReceive(Upstream.refreshed) { _ in
                print("[ DEBUG ] refreshing servers …")
                Task {
                    await viewModel.fetch(
                        session: authentication.session
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
