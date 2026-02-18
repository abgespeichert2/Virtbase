//
//  ServerRowView.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 17.02.26.
//

import SwiftUI

struct ServerRowView: View {
    
    @EnvironmentObject private
    var authentication: AuthenticationModel
    
    @StateObject private
    var viewModel: ServerStateViewModel = .init()
    
    var server: Server
    
    var body: some View {
        VStack(spacing: 10) {
            
            ServerChartView(server: server)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
            
            Divider()
            
            NavigationLink {
                ServerDetailView(server: server)
            } label: {
                VStack(alignment: .leading) {
                    Text(server.name)
                        .monospaced()
                        .lineLimit(1)
                   
                    HStack {
                        if let status = viewModel.state?.status {
                            ServerStatusView(status: status)
                        }
                        
                        if let task = viewModel.state?.task {
                            ProgressView()
                                .controlSize(.mini)
                            
                            ServerTaskView(task: task)
                        }
                    }
                }
            }
        }
        .frame(height: 220)
        .task {
            await viewModel.fetch(
                session: authentication.session,
                server: server
            )
        }
        .onReceive(Upstream.refreshed) { _ in
            print("[ DEBUG ] refreshing state …")
            Task {
                await viewModel.fetch(
                    session: authentication.session,
                    server: server
                )
            }
        }
    }
}
