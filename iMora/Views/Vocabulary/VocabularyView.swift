//
//  GrammarView.swift
//  iMora
//
//  Created by Jonathan Mora on 23/05/25.
//
import SwiftUI


struct VocabularyView: View {
    @Environment(\.dismiss) var dismiss
    //@Binding var showInputText: Bool
    @EnvironmentObject var coordinator: Coordinator



    let cards: [Flashcard] = [
        Flashcard(word: "Discriminate",
                  example: "Sarah couldn’t discriminate between a good wine and a bad wine, so she avoided wine tastings.",
                  translation: "Distinguir"),
        Flashcard(word: "Persist",
                  example: "You must persist even when things get tough.",
                  translation: "Persistir"),
        Flashcard(word: "Discriminate",
                  example: "Sarah couldn’t discriminate between a good wine and a bad wine, so she avoided wine tastings.",
                  translation: "Distinguir"),
        Flashcard(word: "Persist",
                  example: "You must persist even when things get tough.",
                  translation: "Persistir")
        
    ]

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0){
                HStack {
                    Spacer()
                    Button {
                        coordinator.dismissCover()
                    } label: {
                        Image(systemName: "xmark")
                        
                    }
                    .buttonStyle(ButtonXmarxStyle())
                    .padding()
                }

                Text("Vocabulary")
                    .titleSectionHeader()

                TabView {
                    ForEach(cards) { card in
                        FlashcardView(card: card)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            }
        }
    }
}



#Preview {
    VocabularyView()
}


struct Flashcard: Identifiable {
    let id = UUID()
    let word: String
    let example: String
    let translation: String
}

struct FlashcardView: View {
    let card: Flashcard

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(card.word)
                .titleInfo()
            Divider()

            Text("CAN YOU GUESS THE MEANING?")
                .subtitleInfo()
            

            Text(card.example)
                .descriptionsInfo()

            HStack {
                Text("tap for meaning")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "speaker.wave.2.fill")
                    .foregroundColor(.gray)
            }
        }
        .cardRoundCorner()
    }
}
