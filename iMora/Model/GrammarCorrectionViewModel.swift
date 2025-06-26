import SwiftUI
import FoundationModels

@available(iOS 26.0, *)
@MainActor
class GrammarCorrectionViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var correctedText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    
    let session = LanguageModelSession()

    
    func fixGrammar() async {
        guard !inputText.isEmpty else {
            errorMessage = "Please enter text to correct"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let instructions = """
                Suggest five related topics. Keep them concise (three to seven words) and make sure they \
                build naturally from the person's topic.
                """


            if #available(iOS 26.0, *) {
                let session = LanguageModelSession(instructions: instructions)
            } else {
                // Fallback on earlier versions
            }


            let prompt = "Making homemade bread"
            let response = try await session.respond(to: prompt)
            print("Response: \(response)")
            
        } catch {
            errorMessage = "Error correcting text: \(error.localizedDescription)"
            print("Error: \(errorMessage)")
        }
        
        isLoading = false
    }
}
