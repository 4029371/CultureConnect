import SwiftUI

struct AskQuestionView: View {
    @EnvironmentObject var questionStore: QuestionStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var questionText: String = ""
    @State private var category: PostCategory = .general
    
    // (in real app we'd use logged in user)
    let askerName = "Liam 🇦🇺"
    let askerUni  = "UniMelb"
    
    var canPost: Bool {
        !questionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
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
        // for demo we just clear the form instead of popping views
        questionText = ""
        category = .general
    }
}

#Preview {
    AskQuestionView()
        .environmentObject(QuestionStore())
}
