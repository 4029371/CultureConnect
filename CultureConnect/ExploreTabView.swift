import SwiftUI

struct ExploreTabView: View {
    @EnvironmentObject var postStore: PostStore
    @State private var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader { geo in
            let availableWidth  = geo.size.width
            let availableHeight = geo.size.height
            
            TabView(selection: $currentIndex) {
                ForEach(postStore.posts.indices, id: \.self) { index in
                    FullScreenPostView(post: postStore.posts[index])
                        .frame(width: availableWidth, height: availableHeight)
                        .rotationEffect(.degrees(-90))
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .rotationEffect(.degrees(90))
            .frame(width: availableHeight, height: availableWidth)
            .position(
                x: availableWidth / 2,
                y: availableHeight / 2
            )
            .background(Color(.systemBackground))
        }
        .ignoresSafeArea(edges: [])
        .background(Color(.systemBackground))
    }
}

#Preview {
    NavigationStack {
        ExploreTabView()
            .navigationTitle("CultureConnect")
            .navigationBarTitleDisplayMode(.inline)
    }
    .environmentObject(PostStore())
}
