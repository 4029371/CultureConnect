import SwiftUI

struct FullScreenPostView: View {
    // MARK: - Properties
    let post: Post
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea([]) // don't run under bars
            
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
                
                // Title / hook (for answers this is the question text)
                Text(post.title)
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading) // <- force left
                
                // Colored bordered answer box
                ZStack {
                    // Border
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(
                            post.category.color,
                            lineWidth: 2
                        )
                        .background(
                            // Inner fill
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(post.category.color.opacity(0.12))
                        )
                    
                    // Scrollable body text
                    ScrollView {
                        Text(post.body)
                            .font(.system(.body, design: .rounded))
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading) // <- force left
                            .padding(16)
                            .fixedSize(horizontal: false, vertical: true)
                            .textSelection(.enabled)
                    }
                    .scrollIndicators(.never)
                }
                .frame(maxHeight: .infinity)
                
                // Author / trust block
                HStack(alignment: .top, spacing: 12) {
                    // Avatar bubble
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
                                    .accessibilityLabel("Verified lived experience contributor")
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
                .padding(.top, 8)
                
                // Social row
                HStack(spacing: 20) {
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
            // Safe-ish padding so we don't sit behind the tab bar / title
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
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

private func timeAgoString(from date: Date) -> String {
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

// MARK: - Preview
#Preview {
    FullScreenPostView(post: Post.samplePosts[0])
}
