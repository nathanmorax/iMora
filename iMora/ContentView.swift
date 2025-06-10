//
//  ContentView.swift
//  iMora
//
//  Created by Jonathan Mora on 17/05/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: GrammarViewModel
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var networkMonitor = NetworkMonitor.shared
    
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                NetworkMonitorErrorView(networkMonitor: networkMonitor)
                
                
                TextCorrectionTabView(viewModel: viewModel)
               
                
            }
            .blur(radius: coordinator.showBlur ? 12 : 0)
            
            HStack {
                
                Spacer()
                
                FloatingMenu(showBlur: $coordinator.showBlur)
                
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}


struct TextCorrectionTabView: View {
    
    @ObservedObject var viewModel: GrammarViewModel
    
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


#Preview {
    ContentView(viewModel: GrammarViewModel())
        .environmentObject(Coordinator(grammarViewModel: GrammarViewModel()))
}


struct inputText: View {
    @ObservedObject var viewModel: GrammarViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    
    var body: some View {
        VStack(spacing: 12) {
            TextEditor(text: $viewModel.inputText)
                .editorStyle()
            
            Button {
                Task {
                    await viewModel.corregirTexto()
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
    inputText(viewModel: GrammarViewModel())
}



struct TranslaterView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            
            Button {
                coordinator.dismissSheet()
            } label: {
                Text("Cerrar")
            }
            .buttonStyle(ButtonXmarxStyle())
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TranslaterView()
}

struct NetworkMonitorErrorView: View {
    
    var networkMonitor: NetworkMonitor
    var body: some View {
        
        VStack {
            if let networkErrorMessage = networkMonitor.isConnected ? nil : "No estás conectado a Internet." {
                Text(networkErrorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding()
            }
        }
       
    }
}
