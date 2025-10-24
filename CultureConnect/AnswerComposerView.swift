import SwiftUI

struct AnswerComposerView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var postStore: PostStore
    
    let question: Question
    
    @State private var answerTitle: String = ""
    @State private var answerBody: String = ""
    
    // stub "current user" info for demo
    let authorName: String = "You 🌏"
    let authorTag: String  = "Sharing from lived experience"
    let authorUni: String? = "Demo University"
    let isVerified: Bool   = false
    
    var canPost: Bool {
        !answerTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !answerBody.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        Form {
            Section("Question") {
                Text(question.text)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                Text(question.category.rawValue)
                    .font(.caption2)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(question.category.color.opacity(0.15))
                    )
                    .foregroundColor(question.category.color)
            }
            
            Section("Your headline") {
                TextField("Give your answer a headline...", text: $answerTitle)
                    .textInputAutocapitalization(.sentences)
            }
            
            Section("Your answer") {
                TextEditor(text: $answerBody)
                    .frame(minHeight: 160)
                    .textInputAutocapitalization(.sentences)
            }
            
            Section {
                Button {
                    postAnswer()
                } label: {
                    Text("Post Answer")
                        .frame(maxWidth: .infinity)
                }
                .disabled(!canPost)
            }
        }
        .navigationTitle("Your answer")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func postAnswer() {
        let newPost = Post(
            id: UUID(),
            questionID: question.id,
            questionText: question.text,
            title: answerTitle,
            body: answerBody,
            authorDisplayName: authorName,
            authorCulturalTag: authorTag,
            authorUniversity: authorUni,
            category: question.category,
            timestamp: Date(),
            isVerified: isVerified,
            likeCount: 0,
            commentCount: 0,
            comments: [],
            isReported: false
        )
        
        postStore.addPost(newPost)
        dismiss()
    }
}

#Preview {
    AnswerComposerView(
        question: Question.sampleQuestions[0]
    )
    .environmentObject(PostStore())
}
