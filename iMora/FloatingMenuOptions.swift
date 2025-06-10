//
//  FloatingMenuOptions.swift
//  iMora
//
//  Created by Jonathan Mora on 21/05/25.
//
import SwiftUI

enum FloatingMenuAction: CaseIterable, Identifiable, FloatingMenuItem {
    case writter
    case vocabulary
    case translater
    
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .writter: return "Writter"
        case .vocabulary: return "Vocabulary"
        case .translater: return "Translater"
        }
    }
    
    var icon: String {
        switch self {
        case .writter: return "pencil"
        case .vocabulary: return "textformat.alt"
        case .translater: return "translate"
        }
    }
}


protocol FloatingMenuItem: Identifiable, CaseIterable {
    var title: String { get }
    var icon: String { get }
}


struct FloatingMenuOptions<Item: FloatingMenuItem>: View {
    let item: Item
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Text(item.title)
                    .prefixedWithSFSymbol(named: item.icon)
            }
        }
        .buttonStyle(FloatingOptionsButtonStyle(isSelected: isSelected))
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    FloatingMenuOptions(
        item: FloatingMenuAction.vocabulary,
        isSelected: true,
        onTap: {}
    )
    FloatingMenuOptions(
        item: FloatingMenuAction.translater,
        isSelected: true,
        onTap: {}
    )
    .padding()
}



