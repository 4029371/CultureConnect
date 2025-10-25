import SwiftUI

struct ContentView: View {
    @StateObject private var postStore = PostStore()
    @StateObject private var questionStore = QuestionStore()
    
    @State private var isAuthenticated = false
    
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

#Preview {
    ContentView()
}
