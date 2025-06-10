//
//  ErrorHandler.swift
//  iMora
//
//  Created by Jonathan Mora on 29/05/25.
//

import Network
import SwiftUI

final class NetworkMonitor: ObservableObject {
    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")

    @Published var isConnected: Bool = true

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
}





struct ErrorHandler {
    static func userFriendlyMessage(from error: Error) -> String {
        if !NetworkMonitor.shared.isConnected {
            return "Sin conexión a Internet. Por favor, revisa tu conexión."
        }
        
        let rawError = error.localizedDescription.lowercased()

        if rawError.contains("quota") || rawError.contains("exceeded") {
            return "Has superado tu límite de uso. Por favor, revisa tu plan."
        }

        if rawError.contains("failed to decode") || rawError.contains("url") || rawError.contains("network") {
            return "Ha ocurrido un error técnico. Por favor, intenta más tarde."
        }

        return "Ocurrió un error inesperado. Intenta de nuevo más tarde."
    }
}


