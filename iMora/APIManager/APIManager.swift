//
//  APIManager.swift
//  iMora
//
//  Created by Jonathan Mora on 20/05/25.
//
import Foundation

enum NetworkError: Error, LocalizedError {
    case badURLResponse(underlyingError: Error)
    case dataLoadingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)
    case urlBuildFailed
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(underlyingError: let error):
            return "Failed to parse URL response: \(error.localizedDescription)."
            
        case .dataLoadingFailed(underlyingError: let error):
            return "Failed to load data from API configuration file: \(error.localizedDescription)."
        case .decodingFailed(underlyingError: let error):
            return "Failed to decode API configuration: \(error.localizedDescription)."
        case .urlBuildFailed:
            return "Failed to build URL."
        }
    }
    
}

var otherAPIAPPleID = "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"

let APIKey = "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"


class APIManager {
    static let shared = APIManager()
    
    func fetchHelp(inputText: String) async throws -> String {
        let prompt = "Corrige este texto en inglés: \(inputText)"
        
        let headers = [
            "Authorization": "Bearer \(otherAPIAPPleID)",
            "Content-Type": "application/json"
        ]
        
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "Eres un corrector gramatical de inglés."],
                ["role": "user", "content": prompt]
            ]
        ]
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw NetworkError.urlBuildFailed
        }
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            throw NetworkError.decodingFailed(underlyingError: NSError(domain: "JSONEncoding", code: -1))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.allHTTPHeaderFields = headers
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        
        if let json = jsonObject as? [String: Any],
           let error = json["error"] as? [String: Any],
           let message = error["message"] as? String {
            throw NetworkError.badURLResponse(
                underlyingError: NSError(domain: "OpenAIError", code: -1, userInfo: [NSLocalizedDescriptionKey: message])
            )
        }

        if let json = jsonObject as? [String: Any],
           let choices = json["choices"] as? [[String: Any]],
           let message = choices.first?["message"] as? [String: Any],
           let content = message["content"] as? String {
            return content.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            throw NetworkError.decodingFailed(
                underlyingError: NSError(domain: "UnexpectedFormat", code: -1)
            )
        }
    }
    
    func userFriendlyErrorMessage(from error: Error) -> String {
        let rawError = error.localizedDescription.lowercased()

        if rawError.contains("quota") || rawError.contains("exceeded") {
            return "Has superado tu límite de uso. Por favor, revisa tu plan."
        } else if rawError.contains("failed to decode") {
            return "Error al procesar la respuesta del servidor."
        } else if rawError.contains("url") {
            return "Error interno de la aplicación."
        } else {
            return "Ocurrió un error inesperado. Intenta de nuevo más tarde."
        }
    }

}


