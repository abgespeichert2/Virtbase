//
//  KeyAuthenticationView.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 12.02.26.
//

import SwiftUI

struct KeyAuthenticationView: View {
    
    @Environment(\.dismiss) private
    var dismiss
    
    @State private
    var token: String = ""
    
    @Environment(\.openURL)
    private var openURL
    
    @EnvironmentObject private
    var authentication: AuthenticationModel
    
    var body: some View {
        NavigationStack {
            List {
                Section("Schlüssel") {
                    if authentication.state == .deauthenticated {
                        SecureField("oBdfzj …", text: $token)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .submitLabel(.return)
                            .monospaced()
                    } else if authentication.state == .processing {
                        HStack {
                            Text("Bearbeitung")
                            Spacer(minLength: 0)
                            ProgressView()
                        }
                    }
                }
                
                Section("Optionen") {
                    Button {
                        Task {
                            guard let token = UIPasteboard.general.string else { return }
                            try await authentication.authenticate(token: token)
                        }
                    } label: {
                        HStack {
                            Image(systemName: "document.on.clipboard.fill")
                                .foregroundStyle(.tint)
                                .frame(minWidth: 25)
                            
                            Text("Einfügen")
                        }
                    } .buttonStyle(.plain)
                    
                    Button {
                        let url = URL(string: "https://app.virtbase.com/account/settings/api")!
                        openURL(url)
                    } label: {
                        HStack {
                            Image(systemName: "network")
                                .foregroundStyle(.tint)
                                .frame(minWidth: 25)
                            
                            Text("Erstellen")
                        }
                    } .buttonStyle(.plain)
                }
            }
            .navigationTitle("Verifizieren")
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Zurück") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fortfahren") {
                        Task {
                            guard !token.isEmpty else { return }
                            try await authentication.authenticate(token: token)
                        }
                    }
                    .disabled(token.isEmpty)
                }
            }
        }
    }
}
