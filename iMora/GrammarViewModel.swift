//
//  GrammarViewModel.swift
//  iMora
//
//  Created by Jonathan Mora on 20/05/25.
//

import SwiftUI

@MainActor
class GrammarViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var correctedText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func corregirTexto() async {
        correctedText = ""
        errorMessage = nil
        isLoading = true
        
        
        if !NetworkMonitor.shared.isConnected {
            errorMessage = "Sin conexión a Internet. Por favor, revisa tu conexión."
            isLoading = false
            return
        }
        
        
        do {
            let corrected = try await APIManager.shared.fetchHelp(inputText: inputText)
            correctedText = corrected
        } catch {
            errorMessage = ErrorHandler.userFriendlyMessage(from: error)
            print("DEBUG ERROR: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
}
