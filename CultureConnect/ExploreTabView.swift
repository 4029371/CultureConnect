import SwiftUI

struct ExploreTabView: View {
    let posts: [Post] = Post.samplePosts
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(posts) { post in
                    PostCardView(post: post)
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 80) // keep clear of tab bar bounce
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    ExploreTabView()
}
