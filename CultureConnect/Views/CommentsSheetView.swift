import SwiftUI

struct CommentsSheetView: View {
    // MARK: - Properties
    let post: Post
    @ObservedObject var postStore: PostStore
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var newCommentText: String = ""
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Comments list
                if post.comments.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "text.bubble")
                            .font(.system(size: 32))
                            .foregroundColor(.secondary)
                        Text("No comments yet")
                            .font(.headline)
                        Text("Start the conversation.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 24)
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(post.comments) { comment in
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack(spacing: 6) {
                                        Text(comment.authorDisplayName)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text(timeAgoString(from: comment.timestamp))
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)
                                    }
                                    
                                    Text(comment.body)
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                    
                                    Divider()
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 80) // leave space for input bar
                    }
                }
                
                // Input bar
                HStack(alignment: .bottom, spacing: 12) {
                    TextField("Add a comment…", text: $newCommentText, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(1...4)
                    
                    Button {
                        submitComment()
                    } label: {
                        Text("Post")
                            .font(.system(.headline, design: .rounded, weight: .semibold))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(newCommentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                          ? Color.gray.opacity(0.3)
                                          : Color.blue)
                            )
                            .foregroundColor(.white)
                    }
                    .disabled(newCommentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(.regularMaterial)
            }
            .navigationTitle("Comments")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: - Methods
    private func submitComment() {
        let trimmed = newCommentText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        // Very simple "me" author model
        let newComment = Comment(
            id: UUID(),
            authorDisplayName: "Me 🇦🇺",
            body: trimmed,
            timestamp: Date()
        )
        
        postStore.addComment(newComment, to: post.id)
        newCommentText = ""
    }
}

// MARK: - Preview
#Preview {
    CommentsSheetView(
        post: Post.samplePosts[0],
        postStore: PostStore()
    )
}
