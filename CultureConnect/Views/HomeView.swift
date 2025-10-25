import SwiftUI

struct HomeView: View {
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var questionStore: QuestionStore
    
    @State private var answerPath: [AnswerRoute] = []
    // MARK: - Properties
    let onLogout: () -> Void
    
    // MARK: - Body
    var body: some View {
        TabView {
            // 1. Explore
            ExploreTabView()
                .tabItem {
                    Label("Explore", systemImage: "house.fill")
                }
            
            // 2. Categories
            CategoriesTabView()
                .tabItem {
                    Label("Categories", systemImage: "square.grid.2x2.fill")
                }
            
            // 3. Ask
            NavigationStack {
                AskQuestionView()
            }
            .tabItem {
                Label("Ask", systemImage: "questionmark.bubble.fill")
            }
            
            // 4. Answer
            NavigationStack(path: $answerPath) {
                AnswerMenuView(path: $answerPath)
                    .navigationDestination(for: AnswerRoute.self) { route in
                        switch route {
                        case .pickQuestion:
                            PickQuestionToAnswerView(path: $answerPath)
                        case .writeCustomAnswer:
                            CustomAnswerComposerView()
                        case .composeForQuestion(let question):
                            AnswerComposerView(question: question)
                        }
                    }
            }
            .tabItem {
                Label("Answer", systemImage: "pencil.and.outline")
            }
            
            // 5. Account
            NavigationStack {
                AccountTabView(onLogout: onLogout)
            }
            .tabItem {
                Label("Account", systemImage: "person.crop.circle")
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("CultureConnect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
#Preview {
    HomeView(onLogout: {})
        .environmentObject(PostStore())
        .environmentObject(QuestionStore())
}
