import SwiftUI

struct HomeView: View {
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var questionStore: QuestionStore
    
    var body: some View {
        TabView {
            // 1. Explore feed (answers)
            ExploreTabView()
                .tabItem {
                    Label("Explore", systemImage: "house.fill")
                }
            
            // 2. Categories
            CategoriesTabView()
                .tabItem {
                    Label("Categories", systemImage: "square.grid.2x2.fill")
                }
            
            // 3. Ask a question
            AskQuestionView()
                .tabItem {
                    Label("Ask", systemImage: "questionmark.bubble.fill")
                }
            
            // 4. Answer a question
            AnswerFlowRootView()
                .tabItem {
                    Label("Answer", systemImage: "pencil.and.outline")
                }
            
            // 5. Account / Logout
            AccountTabView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("CultureConnect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(PostStore())
    .environmentObject(QuestionStore())
}
