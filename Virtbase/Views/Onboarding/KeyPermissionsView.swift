//
//  KeyPermissionsView.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 12.02.26.
//

import SwiftUI

struct KeyPermissionsView: View {
    
    @Environment(\.dismiss) private
    var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                
                Section {
                    
                    HStack(spacing: 10) {
                        Text("KVM")
                            .monospaced()
                        
                        Spacer(minLength: 0)
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.subheadline)
                                .foregroundStyle(.green)
                            Text("Lesen")
                        }
                        .frame(minWidth: 80)
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.subheadline)
                                .foregroundStyle(.green)
                            Text("Schreiben")
                        }
                        .frame(minWidth: 80)
                    }
                    
                    HStack(spacing: 10) {
                        Text("rDNS")
                            .monospaced()
                        
                        Spacer(minLength: 0)
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.subheadline)
                                .foregroundStyle(.green)
                            Text("Lesen")
                        }
                        .frame(minWidth: 80)
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.subheadline)
                                .foregroundStyle(.green)
                            Text("Schreiben")
                        }
                        .frame(minWidth: 80)
                    }
                    
                    HStack(spacing: 10) {
                        Text("Firewall")
                            .monospaced()
                        
                        Spacer(minLength: 0)
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.subheadline)
                                .foregroundStyle(.green)
                            Text("Lesen")
                        }
                        .frame(minWidth: 80)
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.subheadline)
                                .foregroundStyle(.green)
                            Text("Schreiben")
                        }
                        .frame(minWidth: 80)
                    }
                    
                    HStack(spacing: 10) {
                        Text("Backups")
                            .monospaced()
                        
                        Spacer(minLength: 0)
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.subheadline)
                                .foregroundStyle(.green)
                            Text("Lesen")
                        }
                        .frame(minWidth: 80)
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.subheadline)
                                .foregroundStyle(.green)
                            Text("Schreiben")
                        }
                        .frame(minWidth: 80)
                    }
                    
                    HStack(spacing: 10) {
                        Text("Konsole")
                            .monospaced()
                        
                        Spacer(minLength: 0)
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.subheadline)
                                .foregroundStyle(.green)
                            Text("Lesen")
                        }
                        .frame(minWidth: 80)
                        
                        HStack {
                            Image(systemName: "xmark.circle.fill")
                                .font(.subheadline)
                                .foregroundStyle(.red)
                            Text("Schreiben")
                        }
                        .frame(minWidth: 80)
                    }
                    
                } header: {
                    Text("Schlüssel")
                } footer: {
                    Text("Diese Berechtigungen sind notwendig, damit die Virtbase App ordnungsgemäß funktionieren kann. Das Entfernen oder Einschränken dieser Berechtigungen kann zu Fehlfunktionen der App führen und unauthentifizierte Anfragen verursachen.")
                }
                
            }
            .navigationTitle("Berechtigungen")
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Zurück") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Fortfahren") {
                        KeyAuthenticationView()
                    }
                }
            }
        }
    }
}
