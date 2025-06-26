//
//  FloatingMenuOptions.swift
//  iMora
//
//  Created by Jonathan Mora on 21/05/25.
//

import SwiftUI

enum HoverMenuItem: CaseIterable, Identifiable, HoverMenuItemProtocol {
    case writer
    case vocabulary
    case translator
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .writer: return "Writer"
        case .vocabulary: return "Vocabulary"
        case .translator: return "Translator"
        }
    }
    
    var icon: String {
        switch self {
        case .writer: return "pencil"
        case .vocabulary: return "textformat.alt"
        case .translator: return "translate"
        }
    }
}

protocol HoverMenuItemProtocol: Identifiable, CaseIterable {
    var title: String { get }
    var icon: String { get }
}

struct HoverMenuItemView<Item: HoverMenuItemProtocol>: View {
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
        .buttonStyle(HoverOptionsButtonStyle(isSelected: isSelected))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VStack {
        HoverMenuItemView(
            item: HoverMenuItem.vocabulary,
            isSelected: true,
            onTap: {}
        )
        HoverMenuItemView(
            item: HoverMenuItem.translator,
            isSelected: false,
            onTap: {}
        )
    }
    .padding()
}
