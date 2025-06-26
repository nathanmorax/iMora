//
//  SelectLanguageSheetView.swift
//  iMora
//
//  Created by Jonathan Mora on 25/06/25.
//
import SwiftUI


@available(iOS 26.0, *)
struct SelectLanguageSheetView: View {
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

/*#Preview(traits: .sizeThatFitsLayout) {
    SelectLanguageSheetView()
}*/
