import SwiftUI

struct HomeView: View {
    @EnvironmentObject var postStore: PostStore
    @State private var showComposer = false
    
    var body: some View {
        TabView {
            // Tab 1: Explore / For You
            ExploreTabView()
                .tabItem {
                    Label("Explore", systemImage: "house.fill")
                }

            // Tab 2: Categories
            CategoriesTabView()
                .tabItem {
                    Label("Categories", systemImage: "square.grid.2x2.fill")
                }

            // Tab 4: Account / Logout
            AccountTabView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(PostStore())
}
