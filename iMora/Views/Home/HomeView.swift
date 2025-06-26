//
//  ContentView.swift
//  iMora
//
//  Created by Jonathan Mora on 17/05/25.
//
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: GrammarViewModel
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var networkMonitor = NetworkMonitor.shared
    
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                InternetStatusView(networkMonitor: networkMonitor)
                
                
                CorrectionResultsView(viewModel: viewModel)
               
                
            }
            .blur(radius: coordinator.showBlur ? 12 : 0)
            
            HStack {
                
                Spacer()
                
                HoverMenuView(showBlur: $coordinator.showBlur)
                
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}


#Preview {
    HomeView(viewModel: GrammarViewModel())
        .environmentObject(Coordinator(grammarViewModel: GrammarViewModel()))
}
