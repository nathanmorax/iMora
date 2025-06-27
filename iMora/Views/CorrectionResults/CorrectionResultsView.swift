//
//  CorrectionResultsView.swift
//  iMora
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI


@available(iOS 26.0, *)
struct CorrectionResultsView: View {
    
    @ObservedObject var viewModel: GrammarCorrectionViewModel
    
    var body: some View {
        TabView {
            Text(viewModel.inputText.isEmpty ? "Escribe un texto a corregir en la opcion de Writter." : viewModel.inputText)

                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                }
            Text(viewModel.errorMessage ?? (viewModel.correctedText.isEmpty ? "El texto corregido aparecerá aquí." : viewModel.correctedText))
                .foregroundColor(viewModel.errorMessage == nil ? .white : .red)

                .tabItem {
                    Image(systemName: "checkmark.circle")
                        
                }

        }

        .customTabViewStyle()

    }
}
