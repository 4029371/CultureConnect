import SwiftUI

struct AskQuestionView: View {
    // MARK: - Properties
    @EnvironmentObject var questionStore: QuestionStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var questionText: String = ""
    @State private var category: PostCategory = .general
    
    // Placeholder info
    let askerName = "Me 🇦🇺"
    let askerUni  = "RMIT University"
    
    var canPost: Bool {
        !questionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                Section("Your question") {
                    TextEditor(text: $questionText)
                        .frame(minHeight: 120)
                        .textInputAutocapitalization(.sentences)
                        .overlay(alignment: .topLeading) {
                            if questionText.isEmpty {
                                Text("e.g. What does Lunar New Year actually mean to you and your family?")
                                    .foregroundColor(.secondary)
                                    .padding(.top, 8)
                                    .padding(.leading, 5)
                                    .font(.callout)
                            }
                        }
                }
                
                Section("Category") {
                    Picker("Topic", selection: $category) {
                        ForEach(PostCategory.allCases, id: \.self) { cat in
                            Text(cat.rawValue).tag(cat)
                        }
                    }
                }
                
                Section {
                    Button {
                        addQuestion()
                    } label: {
                        Text("Post Question")
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(!canPost)
                }
            }
            .navigationTitle("Ask a question")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Methods
    private func addQuestion() {
        let q = Question(
            id: UUID(),
            text: questionText,
            category: category,
            askedByDisplayName: askerName,
            askedByUniversity: askerUni,
            timestamp: Date()
        )
        questionStore.addQuestion(q)
        
        // Clear the form
        questionText = ""
        category = .general
    }
}

// MARK: - Preview
#Preview {
    AskQuestionView()
        .environmentObject(QuestionStore())
}
