import SwiftUI

struct CustomAnswerComposerView: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var postStore: PostStore
    
    @State private var headline: String = ""
    @State private var bodyText: String = ""
    @State private var category: PostCategory = .general
    
    // pretend user info
    let authorName: String = "You 🌏"
    let authorTag: String  = "Sharing from lived experience"
    let authorUni: String? = "Demo University"
    let isVerified: Bool   = false
    
    var canPost: Bool {
        !headline.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !bodyText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // MARK: - Body
    var body: some View {
        Form {
            Section("Your headline") {
                TextField("e.g. What Ramadan actually feels like as a student", text: $headline)
                    .textInputAutocapitalization(.sentences)
            }
            
            Section("Category") {
                Picker("Topic", selection: $category) {
                    ForEach(PostCategory.allCases, id: \.self) { cat in
                        Text(cat.rawValue).tag(cat)
                    }
                }
            }
            
            Section("Your answer") {
                TextEditor(text: $bodyText)
                    .frame(minHeight: 160)
                    .textInputAutocapitalization(.sentences)
            }
            
            Section {
                Button {
                    postAnswer()
                } label: {
                    Text("Share")
                        .frame(maxWidth: .infinity)
                }
                .disabled(!canPost)
            }
        }
        .navigationTitle("Share your experience")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Methods
    private func postAnswer() {
        // We generate a fake "question" from their headline.
        let fakeQID = UUID()
        
        let newPost = Post(
            id: UUID(),
            questionID: fakeQID,
            questionText: headline,
            title: headline,
            body: bodyText,
            authorDisplayName: authorName,
            authorCulturalTag: authorTag,
            authorUniversity: authorUni,
            category: category,
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

// MARK: - Preview
#Preview {
    CustomAnswerComposerView()
        .environmentObject(PostStore())
}
