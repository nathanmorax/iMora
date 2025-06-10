//
//  Coordinator.swift
//  iMora
//
//  Created by Jonathan Mora on 23/05/25.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    @Published var showBlur: Bool = false
    

    let grammarViewModel: GrammarViewModel

    init(grammarViewModel: GrammarViewModel) {
        self.grammarViewModel = grammarViewModel
    }

    func push(page: AppPages) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
        self.showBlur = true

    }

    func presentFullScreenCover(_ cover: FullScreenCover) {
        self.fullScreenCover = cover

    }

    func dismissSheet() {
        self.sheet = nil
        self.showBlur = false

    }

    func dismissCover() {
        self.fullScreenCover = nil
        self.showBlur = false

    }

    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .main:
            ContentView(viewModel: grammarViewModel)
        }
    }

    @ViewBuilder
    func buildSheet(sheet: Sheet) -> some View {
        switch sheet {
        case .inputText:
            inputText(viewModel: grammarViewModel)
        case .translater:
            TranslaterView()
        }
    }

    @ViewBuilder
    func buildCover(cover: FullScreenCover) -> some View {
        switch cover {
        case .vocabulary:
            VocabularyView()
        }
    }
}



