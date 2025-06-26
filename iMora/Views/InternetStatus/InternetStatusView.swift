//
//  InternetStatusView.swift
//  iMora
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

struct InternetStatusView: View {
    
    var networkMonitor: NetworkMonitor
    var body: some View {
        
        VStack {
            if let networkErrorMessage = networkMonitor.isConnected ? nil : "No estás conectado a Internet." {
                Text(networkErrorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding()
            }
        }
       
    }
}
