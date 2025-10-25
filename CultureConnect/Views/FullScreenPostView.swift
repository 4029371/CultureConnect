import SwiftUI

struct FullScreenPostView: View {
    // MARK: - Properties
    let post: Post
    @EnvironmentObject var postStore: PostStore
    @State private var showingComments = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea([])
            
            VStack(alignment: .leading, spacing: 16) {
                
                // Top row: category chip + time
                HStack(alignment: .firstTextBaseline) {
                    Text(post.category.rawValue)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(post.category.color.opacity(0.15))
                        )
                        .foregroundColor(post.category.color)
                    
                    Spacer()
                    
                    Text(timeAgoString(from: post.timestamp))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                
                // Title
                Text(post.title)
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Colored bordered answer box
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(post.category.color, lineWidth: 2)
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(post.category.color.opacity(0.12))
                        )
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
                    
                    ScrollView {
                        Text(post.body)
                            .font(.system(.body, design: .rounded))
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                            .padding(16)
                            .fixedSize(horizontal: false, vertical: true)
                            .textSelection(.enabled)
                    }
                    .scrollIndicators(.never)
                    
                    // Bottom-right overlay (likes, comments, share)
                    VStack {
                        Spacer()
                        HStack(spacing: 10) {
                            // likes
                            HStack(spacing: 4) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.pink)
                                    .font(.system(size: 18, weight: .semibold))
                                Text("\(post.likeCount)")
                                    .foregroundColor(.pink)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            // comments (tappable)
                            Button {
                                showingComments = true
                            } label: {
                                HStack(spacing: 4) {
                                    Image(systemName: "text.bubble.fill")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 18, weight: .semibold))
                                        .offset(y: 1)
                                    Text("\(post.commentCount)")
                                        .foregroundColor(.blue)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .buttonStyle(.plain)
                            
                            // share
                            Button {
                                print("share tapped")
                            } label: {
                                Image(systemName: "arrow.up.square.fill")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.green)
                            }
                            
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(.systemBackground).opacity(0.0),
                                    Color(.systemBackground).opacity(0.7)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                        )
                    }
                    .padding(4)
                }
                .frame(maxHeight: .infinity)
                
                // Answered by
                Text("Answered by \(post.authorDisplayName)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.leading, 4)
                
                // Author / trust block
                HStack(alignment: .center, spacing: 12) {
                    // Avatar
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.blue.opacity(0.8),
                                        Color.purple.opacity(0.8)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 44, height: 44)
                        
                        Text(initials(from: post.authorDisplayName))
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 4) {
                            Text(post.authorDisplayName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            if post.isVerified {
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        Text(post.authorCulturalTag)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        if let uni = post.authorUniversity {
                            Text(uni)
                                .font(.caption2)
                                .foregroundStyle(.tertiary)
                        }
                    }
                    
                    Spacer()
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
                )
                .padding(.top, 8)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
        // Comments sheet
        .sheet(isPresented: $showingComments) {
            CommentsSheetView(
                post: post,
                postStore: postStore
            )
        }
    }
}

// MARK: - Methods
private func initials(from name: String) -> String {
    let parts = name.split(separator: " ")
    if let first = parts.first {
        let letters = first.filter { $0.isLetter }
        if let c = letters.first {
            return String(c).uppercased()
        }
    }
    return "·"
}

public func timeAgoString(from date: Date) -> String {
    let seconds = Int(Date().timeIntervalSince(date))
    if seconds < 60 {
        return "just now"
    } else if seconds < 3600 {
        return "\(seconds / 60)m ago"
    } else if seconds < 86400 {
        return "\(seconds / 3600)h ago"
    } else {
        return "\(seconds / 86400)d ago"
    }
}

// MARK: - Preview
#Preview {
    FullScreenPostView(post: Post.samplePosts[0])
        .environmentObject(PostStore())
}
