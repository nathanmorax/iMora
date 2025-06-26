//
//  TextInputBottomSheet.swift
//  iMora
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI

struct TextInputBottomSheet: View {
    @ObservedObject var viewModel: GrammarViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    
    var body: some View {
        VStack(spacing: 12) {
            TextEditor(text: $viewModel.inputText)
                .editorStyle()
            
            Button {
                Task {
                    //await viewModel.corregirTexto()
                    coordinator.dismissSheet()
                    
                }
            } label: {
                Text(viewModel.isLoading ? "Analizando..." : "Analizar texto")
                   
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(viewModel.isLoading)
            .padding(.horizontal, 42)
            .padding(.vertical, 24)
            
        }
        .shadow(radius: 14)
        .background(Color.primaryBackground)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TextInputBottomSheet(viewModel: GrammarViewModel())
}
