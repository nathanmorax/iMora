//
//  FloatingMenu.swift
//  iMora
//
//  Created by Jonathan Mora on 21/05/25.
//
import SwiftUI

@available(iOS 26.0, *)
struct HoverMenuView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Binding var showBlur: Bool
    @State private var showMenu = false
    @State private var selectedAction: HoverMenuItem? = nil
    @State private var showSheet = false
    @State private var showGrammarFullScreen = false
    
    
    
    var body: some View {
        ZStack {
            removoBlur
            
            HStack {
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    if showMenu {
                        Spacer()

                        ForEach(HoverMenuItem.allCases) { action in
                            HoverMenuItemView(item: action,
                                                isSelected: selectedAction == action) {
                                selectedAction = action
                                handleMenuAction(action)
                            }
                        }
                        .transition(.move(edge: .trailing).combined(with: .slide))
                    }

                    if !showMenu {
                        Button {
                            withAnimation {
                                showMenu.toggle()
                                showBlur = showMenu
                            }
                        } label: { Image(systemName: "text.word.spacing") }.buttonStyle(FloatigButtonMenuStyle())
                    }
                }
            }
        }
        .zIndex(1)
        
    }
    
    private var removoBlur: some View {
        Group {
            if showMenu {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            showMenu = false
                            showBlur = false
                        }
                    }
            } else {
                EmptyView()
            }
        }
    }
    
    
    
    private func handleMenuAction(_ action: HoverMenuItem) {
        withAnimation {
            showMenu = false
        }
        
        switch action {
        case .writer:
            coordinator.presentSheet(.inputText)
            showBlur = false
        case .translator:
            coordinator.presentSheet(.translater)
        case .vocabulary:
            coordinator.presentFullScreenCover(.vocabulary)
        }
    }
    
    
}

/*struct FloatingMenu_PreviewWrapper: View {
    @State private var showBlur = false
    @StateObject private var coordinator = Coordinator(grammarViewModel: GrammarViewModel())

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            HoverMenuView(showBlur: $showBlur)
                .environmentObject(coordinator)
        }
    }
}


#Preview("FloatingMenu", traits: .sizeThatFitsLayout) {
    FloatingMenu_PreviewWrapper()
}*/

