import SwiftUI

struct CategoriesTabView: View {
    @EnvironmentObject var postStore: PostStore
    
    @State private var selectedCategory: PostCategoryFilter = .all
    
    var filteredPosts: [Post] {
        switch selectedCategory {
        case .all:
            return postStore.posts
        case .specific(let cat):
            return postStore.posts.filter { $0.category == cat }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Filter bar
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    // "All" chip
                    CategoryFilterChip(
                        label: "All",
                        isSelected: selectedCategory == .all,
                        tint: .gray
                    ) {
                        selectedCategory = .all
                    }
                    
                    // One chip per category
                    ForEach(PostCategory.allCases, id: \.self) { cat in
                        CategoryFilterChip(
                            label: cat.rawValue,
                            isSelected: selectedCategory == .specific(cat),
                            tint: cat.color
                        ) {
                            selectedCategory = .specific(cat)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .background(Color(.systemBackground).opacity(0.9))
            .overlay(
                Divider()
                    .offset(y: 0.5),
                alignment: .bottom
            )
            
            // Post list
            if filteredPosts.isEmpty {
                VStack(spacing: 0) {
                    Text("Nothing here yet")
                        .font(.system(.headline, design: .rounded))
                    
                    Text("Be the first to share your experience in this category.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
            } else {
                ScrollView {
                    LazyVStack(spacing: 0, pinnedViews: []) {
                        ForEach(filteredPosts) { post in
                            CategoryPostCard(post: post)
                                .padding(.horizontal, 16)
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    }
                }
                .background(Color(.systemBackground))
            }
        }
        .navigationTitle("Categories")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
    }
}

// MARK: - Filter type
// We want "All" plus specific categories.
enum PostCategoryFilter: Equatable {
    case all
    case specific(PostCategory)
}

// MARK: - Filter chip view
private struct CategoryFilterChip: View {
    let label: String
    let isSelected: Bool
    let tint: Color
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack(spacing: 6) {
                Text(label)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .lineLimit(1)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule(style: .continuous)
                    .fill(
                        isSelected
                        ? tint.opacity(0.15)
                        : Color(.secondarySystemBackground)
                    )
            )
            .overlay(
                Capsule(style: .continuous)
                    .strokeBorder(
                        isSelected ? tint : Color.primary.opacity(0.08),
                        lineWidth: 1
                    )
            )
            .foregroundColor(isSelected ? tint : .primary)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Post card row
private struct CategoryPostCard: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // headline (which is the question text for answers)
            Text(post.title)
                .font(.system(.headline, design: .rounded, weight: .semibold))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
            
            // author / stats row
            HStack(alignment: .center, spacing: 12) {
                // author + (verified badge if any)
                HStack(spacing: 4) {
                    Text(post.authorDisplayName)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    if post.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer(minLength: 8)
                
                // likes
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.pink)
                    Text("\(post.likeCount)")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                
                // comments
                HStack(spacing: 4) {
                    Image(systemName: "text.bubble.fill")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.blue)
                    Text("\(post.commentCount)")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(post.category.color.opacity(0.08))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(post.category.color, lineWidth: 1.5)
        )
    }
}

#Preview {
    NavigationStack {
        CategoriesTabView()
            .environmentObject(PostStore())
    }
}
