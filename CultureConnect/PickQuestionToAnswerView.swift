import SwiftUI

struct PickQuestionToAnswerView: View {
    @EnvironmentObject var questionStore: QuestionStore
    @EnvironmentObject var postStore: PostStore
    
    // 👇 this comes from AnswerFlowRootView
    @Binding var path: [AnswerRoute]
    
    var body: some View {
        List {
            Section("Tap a question to answer") {
                ForEach(questionStore.questions) { q in
                    Button {
                        // push the composer for the chosen question
                        path.append(.composeForQuestion(q))
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(q.text)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            HStack(spacing: 8) {
                                Text(q.category.rawValue)
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        Capsule()
                                            .fill(q.category.color.opacity(0.15))
                                    )
                                    .foregroundColor(q.category.color)
                                
                                Text("asked by \(q.askedByDisplayName)")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 6)
                    }
                }
            }
        }
        .navigationTitle("Choose a question")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // We need to give PickQuestionToAnswerView a binding for path in previews.
    NavigationStack {
        PickQuestionToAnswerView(
            path: .constant([]) // just a dummy binding for preview
        )
    }
    .environmentObject(PostStore())
    .environmentObject(QuestionStore())
}
