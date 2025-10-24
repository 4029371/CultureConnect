import SwiftUI
import Combine

class PostStore: ObservableObject {
    @Published var posts: [Post]
    
    init(posts: [Post] = Post.samplePosts) {
        self.posts = posts
    }
    
    func addPost(_ post: Post) {
        // prepend
        posts.insert(post, at: 0)
    }
}
