//
//  FloatingMenu.swift
//  iMora
//
//  Created by Jonathan Mora on 21/05/25.
//
import SwiftUI

struct FloatingMenu: View {
    @EnvironmentObject var coordinator: Coordinator
    @Binding var showBlur: Bool
    @State private var showMenu = false
    @State private var selectedAction: FloatingMenuAction? = nil
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

                        ForEach(FloatingMenuAction.allCases) { action in
                            FloatingMenuOptions(item: action,
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
    
    
    
    private func handleMenuAction(_ action: FloatingMenuAction) {
        withAnimation {
            showMenu = false
        }
        
        switch action {
        case .writter:
            coordinator.presentSheet(.inputText)
            showBlur = false
        case .translater:
            coordinator.presentSheet(.translater)
        case .vocabulary:
            coordinator.presentFullScreenCover(.vocabulary)
        }
    }
    
    
}

struct FloatingMenu_PreviewWrapper: View {
    @State private var showBlur = false
    @StateObject private var coordinator = Coordinator(grammarViewModel: GrammarViewModel())

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            FloatingMenu(showBlur: $showBlur)
                .environmentObject(coordinator)
        }
    }
}


#Preview("FloatingMenu", traits: .sizeThatFitsLayout) {
    FloatingMenu_PreviewWrapper()
}

