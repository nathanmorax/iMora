//
//  AppPages.swift
//  iMora
//
//  Created by Jonathan Mora on 23/05/25.
//
import SwiftUI

enum AppPages: Hashable {
    case main
}

enum Sheet: Identifiable {
    case inputText
    case translater

    var id: String {
        switch self {
        case .inputText: return "inputText"
        case .translater: return "translater"
        }
    }
}

enum FullScreenCover: Identifiable {
    case vocabulary
    
    var id: String {
        switch self {
        case .vocabulary: return "vocabulary"
        }
    }
}


enum ActiveMenu {
    case none
    case floatingMenu
    case textVersionMenu
}

