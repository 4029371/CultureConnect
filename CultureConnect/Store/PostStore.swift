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
    
    func addComment(_ comment: Comment, to postID: UUID) {
        if let index = posts.firstIndex(where: { $0.id == postID }) {
            posts[index].comments.append(comment)
            posts[index].commentCount += 1
        }
    }
}

