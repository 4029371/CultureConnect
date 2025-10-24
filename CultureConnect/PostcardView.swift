import SwiftUI

struct PostCardView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Top row: category chip + time
            HStack {
                Text(post.category.rawValue)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color.blue.opacity(0.1))
                    )
                    .foregroundColor(.blue)
                
                Spacer()
                
                Text(timeAgoString(from: post.timestamp))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            // Title / hook
            Text(post.title)
                .font(.system(.headline, design: .rounded, weight: .semibold))
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
            
            // Body (preview / first part)
            Text(post.body)
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.primary)
                .lineLimit(5)
                .fixedSize(horizontal: false, vertical: true)
            
            // Author section
            HStack(alignment: .top, spacing: 12) {
                // Avatar placeholder
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
                        .frame(width: 40, height: 40)
                    
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
                                .accessibilityLabel("Verified lived experience contributor")
                        }
                    }
                    
                    Text(post.authorCulturalTag)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    if let uni = post.authorUniversity {
                        Text(uni)
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                }
                
                Spacer()
            }
            
            // Footer bar with likes / comments
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.pink)
                        .font(.system(size: 14, weight: .semibold))
                    Text("\(post.likeCount)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "text.bubble.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 14, weight: .semibold))
                    Text("\(post.commentCount)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .padding(.top, 4)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.07), radius: 20, y: 10)
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
    
    // MARK: Helpers
    
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
    
    private func timeAgoString(from date: Date) -> String {
        // Relative time
        let seconds = Int(Date().timeIntervalSince(date))
        if seconds < 60 {
            return "just now"
        } else if seconds < 3600 {
            let mins = seconds / 60
            return "\(mins)m ago"
        } else if seconds < 86400 {
            let hrs = seconds / 3600
            return "\(hrs)h ago"
        } else {
            let days = seconds / 86400
            return "\(days)d ago"
        }
    }
}

#Preview {
    ScrollView {
        VStack {
            ForEach(Post.samplePosts) { post in
                PostCardView(post: post)
            }
        }
        .padding(.top, 20)
    }
    .background(Color(.systemBackground))
}
