//
//  CoordinatorView.swift
//  iMora
//
//  Created by Jonathan Mora on 23/05/25.
//
import SwiftUI


@available(iOS 26.0, *)
struct CoordinatorView: View {
    @StateObject private var grammarViewModel = GrammarCorrectionViewModel()
    @StateObject private var coordinator: Coordinator

    init() {
        let grammarViewModel = GrammarCorrectionViewModel()
        _grammarViewModel = StateObject(wrappedValue: grammarViewModel)
        _coordinator = StateObject(wrappedValue: Coordinator(grammarViewModel: grammarViewModel))
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .main)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.buildSheet(sheet: sheet)
                        .presentationDetents([.fraction(0.7), .medium])

                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { item in
                    coordinator.buildCover(cover: item)
                }
        }
        .environmentObject(grammarViewModel)
        .environmentObject(coordinator)

    }
}
