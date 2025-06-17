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
