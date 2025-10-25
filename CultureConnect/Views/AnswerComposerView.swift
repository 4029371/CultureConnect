import SwiftUI

struct AnswerComposerView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var postStore: PostStore
    
    let question: Question
    
    @State private var answerBody: String = ""
    
    // Placeholder user info
    let authorName: String = "Me 🇦🇺"
    let authorTag: String  = "Sharing from lived experience"
    let authorUni: String? = "RMIT University"
    let isVerified: Bool   = false
    
    var canPost: Bool {
        !answerBody
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty
    }
    
    var body: some View {
        Form {
            // Show the question being answered
            Section("Question") {
                Text(question.text)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                
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
            
            // Only ask for the answer now
            Section("Your answer") {
                TextEditor(text: $answerBody)
                    .frame(minHeight: 160)
                    .textInputAutocapitalization(.sentences)
                    .overlay(alignment: .topLeading) {
                        if answerBody.isEmpty {
                            Text("Share your lived experience, context, personal nuance…")
                                .foregroundColor(.secondary)
                                .padding(.top, 8)
                                .padding(.leading, 4)
                                .font(.callout)
                        }
                    }
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
            title: question.text,
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
    AnswerComposerView(question: Question.sampleQuestions[0])
        .environmentObject(PostStore())
}
