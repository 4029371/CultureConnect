import SwiftUI

// MARK: - Filter type
enum PostCategoryFilter: Equatable {
    case all
    case specific(PostCategory)
}

struct CategoriesTabView: View {
    // MARK: - Properties
    @EnvironmentObject var postStore: PostStore
    
    @State private var selectedCategory: PostCategoryFilter = .all
    @State private var navPath: [CategoryRoute] = []
    @State private var searchText: String = ""
    
    // Derived lists (category filter + text search)
    private var filteredPosts: [Post] {
        switch selectedCategory {
        case .all:
            return postStore.posts
        case .specific(let cat):
            return postStore.posts.filter { $0.category == cat }
        }
    }
    
    private var visiblePosts: [Post] {
        let base = filteredPosts
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmed.isEmpty {
            return base
        } else {
            return base.filter { post in
                post.title.localizedCaseInsensitiveContains(trimmed)
            }
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $navPath) {
            VStack(spacing: 0) {
                
                // Filter bar
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        // "All"
                        CategoryFilterChip(
                            label: "All",
                            isSelected: selectedCategory == .all,
                            tint: .gray
                        ) {
                            selectedCategory = .all
                        }
                        
                        // Each category
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
                
                // Search bar
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search questions / headlines…", text: $searchText)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                )
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 4)
                
                // Post list OR empty state
                if visiblePosts.isEmpty {
                    VStack(spacing: 12) {
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
                        LazyVStack(spacing: 12) {
                            ForEach(visiblePosts) { post in
                                Button {
                                    navPath.append(.postDetail(post))
                                } label: {
                                    CategoryPostCard(post: post)
                                }
                                .buttonStyle(.plain)
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 32)
                    }
                    .background(Color(.systemBackground))
                }
            }
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
            
            // destination for tapping a post
            .navigationDestination(for: CategoryRoute.self) { route in
                switch route {
                case .postDetail(let post):
                    FullScreenPostView(post: post)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackButtonHidden(false)
                }
            }
        }
    }
}

// MARK: - Filter chip view
private struct CategoryFilterChip: View {
    // MARK: - Properties
    let label: String
    let isSelected: Bool
    let tint: Color
    let onTap: () -> Void
    
    // MARK: - Body
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
    // MARK: - Properties
    let post: Post
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // headline (for answers this is the question text)
            Text(post.title)
                .font(.system(.headline, design: .rounded, weight: .semibold))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
            
            // author / stats row
            HStack(alignment: .center, spacing: 12) {
                // author + badge
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

// MARK: - Preview
#Preview {
    CategoriesTabView()
        .environmentObject(PostStore())
}
