import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var postStore = PostStore()
    @StateObject private var questionStore = QuestionStore()
    
    @State private var isAuthenticated = false
    
    // MARK: - Body
    var body: some View {
        Group {
            if isAuthenticated {
                HomeView(
                    onLogout: {
                        isAuthenticated = false
                    }
                )
                .environmentObject(postStore)
                .environmentObject(questionStore)
            } else {
                NavigationStack {
                    LandingView(
                        onLoginSuccess: {
                            isAuthenticated = true
                        },
                        onSignupSuccess: {
                            isAuthenticated = true
                        }
                    )
                }
                .environmentObject(postStore)
                .environmentObject(questionStore)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
