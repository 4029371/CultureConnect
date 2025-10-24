import SwiftUI

struct ExploreTabView: View {
    let posts: [Post] = Post.samplePosts
    @State private var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader { geo in
            // The available safe size inside the tab view / nav stack
            let availableWidth  = geo.size.width
            let availableHeight = geo.size.height
            
            // We build a horizontal-paging TabView, rotate it so you swipe vertically,
            // then rotate each page back.
            TabView(selection: $currentIndex) {
                ForEach(posts.indices, id: \.self) { index in
                    FullScreenPostView(post: posts[index])
                        .frame(width: availableWidth, height: availableHeight)
                        .rotationEffect(.degrees(-90))    // page upright again
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .rotationEffect(.degrees(90))                 // make paging vertical
            .frame(width: availableHeight, height: availableWidth)
            .position( // center it back in the real space
                x: availableWidth / 2,
                y: availableHeight / 2
            )
            .background(Color(.systemBackground))
        }
        .ignoresSafeArea(edges: []) // don't smash nav/tab bars
        .background(Color(.systemBackground))
    }
}

#Preview {
    // Preview inside nav + tab shape to simulate real layout
    NavigationStack {
        ExploreTabView()
            .navigationTitle("CultureConnect")
            .navigationBarTitleDisplayMode(.inline)
    }
}
